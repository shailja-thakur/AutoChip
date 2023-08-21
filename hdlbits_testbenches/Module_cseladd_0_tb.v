module top_module_tb;

    reg [30:0] a;
    reg [30:0] b;

    wire [30:0] sum;


    top_module UUT (.a(a), .b(b), .sum(sum));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 31'b0000000000000000000000000000000, 31'b0000000000000000000000000000000, Generated = sum, Reference = 31'b0000000000000000000000000000000
        a = 31'b0000000000000000000000000000000; b = 31'b0000000000000000000000000000000; // Set input values
        #period;
        if (!(sum === 31'b0000000000000000000000000000000)) begin
            $display("Mismatch at index 0: Inputs = ["31'b0000000000000000000000000000000"
 "31'b0000000000000000000000000000000"], Generated = ['sum'], Reference = ["31'b0000000000000000000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 31'b0000000000000000000000000000000, 31'b0000000000000000000000000000001, Generated = sum, Reference = 31'b0000000000000000000000000000001
        a = 31'b0000000000000000000000000000000; b = 31'b0000000000000000000000000000001; // Set input values
        #period;
        if (!(sum === 31'b0000000000000000000000000000001)) begin
            $display("Mismatch at index 1: Inputs = ["31'b0000000000000000000000000000000"
 "31'b0000000000000000000000000000001"], Generated = ['sum'], Reference = ["31'b0000000000000000000000000000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 31'b0000000000000000000000000000000, 31'b0000000000000000000000000000010, Generated = sum, Reference = 31'b0000000000000000000000000000010
        a = 31'b0000000000000000000000000000000; b = 31'b0000000000000000000000000000010; // Set input values
        #period;
        if (!(sum === 31'b0000000000000000000000000000010)) begin
            $display("Mismatch at index 2: Inputs = ["31'b0000000000000000000000000000000"
 "31'b0000000000000000000000000000010"], Generated = ['sum'], Reference = ["31'b0000000000000000000000000000010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 31'b0000000000000000000000000000001, 31'b0000000000000000000000000000010, Generated = sum, Reference = 31'b0000000000000000000000000000011
        a = 31'b0000000000000000000000000000001; b = 31'b0000000000000000000000000000010; // Set input values
        #period;
        if (!(sum === 31'b0000000000000000000000000000011)) begin
            $display("Mismatch at index 3: Inputs = ["31'b0000000000000000000000000000001"
 "31'b0000000000000000000000000000010"], Generated = ['sum'], Reference = ["31'b0000000000000000000000000000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 31'b0000000000000001111111111111111, 31'b0000000000000000000000000000000, Generated = sum, Reference = 31'b0000000000000001111111111111111
        a = 31'b0000000000000001111111111111111; b = 31'b0000000000000000000000000000000; // Set input values
        #period;
        if (!(sum === 31'b0000000000000001111111111111111)) begin
            $display("Mismatch at index 4: Inputs = ["31'b0000000000000001111111111111111"
 "31'b0000000000000000000000000000000"], Generated = ['sum'], Reference = ["31'b0000000000000001111111111111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 31'b0000000000000001111111111111111, 31'b0000000000000000000000000000001, Generated = sum, Reference = 31'b0000000000000010000000000000000
        a = 31'b0000000000000001111111111111111; b = 31'b0000000000000000000000000000001; // Set input values
        #period;
        if (!(sum === 31'b0000000000000010000000000000000)) begin
            $display("Mismatch at index 5: Inputs = ["31'b0000000000000001111111111111111"
 "31'b0000000000000000000000000000001"], Generated = ['sum'], Reference = ["31'b0000000000000010000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 31'b0000000000000001111111111111111, 31'b0000000000000101100110011000001, Generated = sum, Reference = 31'b0000000000000111100110011000000
        a = 31'b0000000000000001111111111111111; b = 31'b0000000000000101100110011000001; // Set input values
        #period;
        if (!(sum === 31'b0000000000000111100110011000000)) begin
            $display("Mismatch at index 6: Inputs = ["31'b0000000000000001111111111111111"
 "31'b0000000000000101100110011000001"], Generated = ['sum'], Reference = ["31'b0000000000000111100110011000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 7);
        $finish;
    end

endmodule