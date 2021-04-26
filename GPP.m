function x = GPP(augmented_matrix, n)
    
    NROW = zeros(1,n); %preallocate NROW size for speed (thanks matlab)
    for i = 1:n %STEP 1
        NROW(i) = i;
    end
    
    for i = 1:n-1 %STEP 2 (ALL OF 'FOR LOOP' is step 2)
       for p = i:n %STEP 3: find the largest p value that satisfies the next line.
           if abs(augmented_matrix(NROW(p),i)) == max( abs(augmented_matrix(NROW(i:n),i)) )
               break
           end
       end
       if augmented_matrix(NROW(p),i) == 0 %STEP 4
           disp("No unique solution exists (matrix(p,i) = 0)")
           return
       end
       
       if NROW(i) ~= NROW(p) %STEP 5 (Simulating row interchange operations: use a temporary variable (NCOPY) in order to switch two rows)
           NCOPY = NROW(i);
           NROW(i) = NROW(p);
           NROW(p) = NCOPY;
       end
       
       for j = i+1:n %STEP 6
          m = augmented_matrix(NROW(j),i) / augmented_matrix(NROW(i),i);
          augmented_matrix(NROW(j),:) = augmented_matrix(NROW(j),:) - m*augmented_matrix(NROW(i),:); %row wise subtraction <- RUDI'S suggested change
       end
     
    end %END STEP 2
    
    if augmented_matrix(NROW(n),n) == 0
        disp("No unique solution exists (matrix(n,n) = 0)")
        return 
    end
    
    %STEP 10: start backward substitution
    x(n) = augmented_matrix(NROW(n),n+1) / augmented_matrix(NROW(n),n); %Assign largest value of x then work backwards
    for i = n-1:-1:1 %loop backwards for n-1 to 1
        j_summation = 0;
        for j = i+1:n %doing the summation part of the formula seperatly for readability
            j_summation = j_summation + augmented_matrix(NROW(i), j) * x(j);
        end
        x(i) = ( augmented_matrix(NROW(i), n+1) - j_summation) / augmented_matrix(NROW(i), i);
    end
    