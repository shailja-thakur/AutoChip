module top_module_tb;


    wire A;
    wire B;


    top_module UUT (.A(A), .B(B));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = , Generated = A, B, Reference = 4'b0000, 4'b0000
        ; // Set input values
        #period;
        if (!(A === 4'b0000 && B === 4'b0000)) begin
            $display("Mismatch at index 0: Inputs = [], Generated = ['A', 'B'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = , Generated = A, B, Reference = 4'b0001, 4'b0000
        ; // Set input values
        #period;
        if (!(A === 4'b0001 && B === 4'b0000)) begin
            $display("Mismatch at index 1: Inputs = [], Generated = ['A', 'B'], Reference = ["4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = , Generated = A, B, Reference = 4'b0001, 4'b0001
        ; // Set input values
        #period;
        if (!(A === 4'b0001 && B === 4'b0001)) begin
            $display("Mismatch at index 2: Inputs = [], Generated = ['A', 'B'], Reference = ["4'b0001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = , Generated = A, B, Reference = 4'b0000, 4'b0001
        ; // Set input values
        #period;
        if (!(A === 4'b0000 && B === 4'b0001)) begin
            $display("Mismatch at index 3: Inputs = [], Generated = ['A', 'B'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = , Generated = A, B, Reference = 4'b0000, 4'b0000
        ; // Set input values
        #period;
        if (!(A === 4'b0000 && B === 4'b0000)) begin
            $display("Mismatch at index 4: Inputs = [], Generated = ['A', 'B'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = , Generated = A, B, Reference = 4'b0000, 4'b0000
        ; // Set input values
        #period;
        if (!(A === 4'b0000 && B === 4'b0000)) begin
            $display("Mismatch at index 5: Inputs = [], Generated = ['A', 'B'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 6);
        $finish;
    end

endmodule