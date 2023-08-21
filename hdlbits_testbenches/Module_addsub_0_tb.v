module top_module_tb;

    reg [30:0] a;
    reg [30:0] b;
    reg sub;

    wire [30:0] sum;


    top_module UUT (.a(a), .b(b), .sub(sub), .sum(sum));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 31'b0000000000000000000000000000000, 31'b0000000000000000000000000000000, 4'b0000, Generated = sum, Reference = 31'b0000000000000000000000000000000
        a = 31'b0000000000000000000000000000000; b = 31'b0000000000000000000000000000000; sub = 4'b0000; // Set input values
        #period;
        if (!(sum === 31'b0000000000000000000000000000000)) begin
            $display("Mismatch at index 0: Inputs = ["31'b0000000000000000000000000000000"
 "31'b0000000000000000000000000000000" "4'b0000"], Generated = ['sum'], Reference = ["31'b0000000000000000000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 31'b0000000000000000000000000000001, 31'b0000000000000000000000000000000, 4'b0000, Generated = sum, Reference = 31'b0000000000000000000000000000001
        a = 31'b0000000000000000000000000000001; b = 31'b0000000000000000000000000000000; sub = 4'b0000; // Set input values
        #period;
        if (!(sum === 31'b0000000000000000000000000000001)) begin
            $display("Mismatch at index 1: Inputs = ["31'b0000000000000000000000000000001"
 "31'b0000000000000000000000000000000" "4'b0000"], Generated = ['sum'], Reference = ["31'b0000000000000000000000000000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 31'b0000000000000000000000000000010, 31'b0000000000000000000000000000000, 4'b0000, Generated = sum, Reference = 31'b0000000000000000000000000000010
        a = 31'b0000000000000000000000000000010; b = 31'b0000000000000000000000000000000; sub = 4'b0000; // Set input values
        #period;
        if (!(sum === 31'b0000000000000000000000000000010)) begin
            $display("Mismatch at index 2: Inputs = ["31'b0000000000000000000000000000010"
 "31'b0000000000000000000000000000000" "4'b0000"], Generated = ['sum'], Reference = ["31'b0000000000000000000000000000010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 31'b0000000000000000000000000000010, 31'b0000000000000000000000000000001, 4'b0001, Generated = sum, Reference = 31'b0000000000000000000000000000001
        a = 31'b0000000000000000000000000000010; b = 31'b0000000000000000000000000000001; sub = 4'b0001; // Set input values
        #period;
        if (!(sum === 31'b0000000000000000000000000000001)) begin
            $display("Mismatch at index 3: Inputs = ["31'b0000000000000000000000000000010"
 "31'b0000000000000000000000000000001" "4'b0001"], Generated = ['sum'], Reference = ["31'b0000000000000000000000000000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 31'b0000000000000000000000000000010, 31'b0000000000000000000000000000010, 4'b0001, Generated = sum, Reference = 31'b0000000000000000000000000000000
        a = 31'b0000000000000000000000000000010; b = 31'b0000000000000000000000000000010; sub = 4'b0001; // Set input values
        #period;
        if (!(sum === 31'b0000000000000000000000000000000)) begin
            $display("Mismatch at index 4: Inputs = ["31'b0000000000000000000000000000010"
 "31'b0000000000000000000000000000010" "4'b0001"], Generated = ['sum'], Reference = ["31'b0000000000000000000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 31'b0000000000000001111111111111111, 31'b0000000000000000000000000000001, 4'b0000, Generated = sum, Reference = 31'b0000000000000010000000000000000
        a = 31'b0000000000000001111111111111111; b = 31'b0000000000000000000000000000001; sub = 4'b0000; // Set input values
        #period;
        if (!(sum === 31'b0000000000000010000000000000000)) begin
            $display("Mismatch at index 5: Inputs = ["31'b0000000000000001111111111111111"
 "31'b0000000000000000000000000000001" "4'b0000"], Generated = ['sum'], Reference = ["31'b0000000000000010000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 31'b0000000000000010000000000000000, 31'b0000000000000000000000000000001, 4'b0001, Generated = sum, Reference = 31'b0000000000000001111111111111111
        a = 31'b0000000000000010000000000000000; b = 31'b0000000000000000000000000000001; sub = 4'b0001; // Set input values
        #period;
        if (!(sum === 31'b0000000000000001111111111111111)) begin
            $display("Mismatch at index 6: Inputs = ["31'b0000000000000010000000000000000"
 "31'b0000000000000000000000000000001" "4'b0001"], Generated = ['sum'], Reference = ["31'b0000000000000001111111111111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 31'b11111111111111111111111111111111, 31'b11111111111111111111111111111111, 4'b0000, Generated = sum, Reference = 31'b11111111111111111111111111111110
        a = 31'b11111111111111111111111111111111; b = 31'b11111111111111111111111111111111; sub = 4'b0000; // Set input values
        #period;
        if (!(sum === 31'b11111111111111111111111111111110)) begin
            $display("Mismatch at index 7: Inputs = ["31'b11111111111111111111111111111111"
 "31'b11111111111111111111111111111111" "4'b0000"], Generated = ['sum'], Reference = ["31'b11111111111111111111111111111110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 8);
        $finish;
    end

endmodule