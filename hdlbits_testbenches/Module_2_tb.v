`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg a;
    reg b;

    wire sum;


    top_module UUT (.a(a), .b(b), .sum(sum));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 16'b0000000000000000, 20'b00000000000000000000, Generated = sum, Reference = 20'b00000000000000000000
        a = 16'b0000000000000000; b = 20'b00000000000000000000; // Set input values
        #period;
        if (!(sum === 20'b00000000000000000000)) begin
            $display("Mismatch at index 0: Inputs = ["16'b0000000000000000" "20'b00000000000000000000"], Generated = ['sum'], Reference = ["20'b00000000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 16'b0000000000000000, 20'b00000000000000000001, Generated = sum, Reference = 20'b00000000000000000001
        a = 16'b0000000000000000; b = 20'b00000000000000000001; // Set input values
        #period;
        if (!(sum === 20'b00000000000000000001)) begin
            $display("Mismatch at index 1: Inputs = ["16'b0000000000000000" "20'b00000000000000000001"], Generated = ['sum'], Reference = ["20'b00000000000000000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 16'b0000000000000000, 20'b00000000000000000010, Generated = sum, Reference = 20'b00000000000000000010
        a = 16'b0000000000000000; b = 20'b00000000000000000010; // Set input values
        #period;
        if (!(sum === 20'b00000000000000000010)) begin
            $display("Mismatch at index 2: Inputs = ["16'b0000000000000000" "20'b00000000000000000010"], Generated = ['sum'], Reference = ["20'b00000000000000000010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 16'b0000000000000001, 20'b00000000000000000010, Generated = sum, Reference = 20'b00000000000000000011
        a = 16'b0000000000000001; b = 20'b00000000000000000010; // Set input values
        #period;
        if (!(sum === 20'b00000000000000000011)) begin
            $display("Mismatch at index 3: Inputs = ["16'b0000000000000001" "20'b00000000000000000010"], Generated = ['sum'], Reference = ["20'b00000000000000000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 16'b1111111111111111, 20'b00000000000000000000, Generated = sum, Reference = 20'b00001111111111111111
        a = 16'b1111111111111111; b = 20'b00000000000000000000; // Set input values
        #period;
        if (!(sum === 20'b00001111111111111111)) begin
            $display("Mismatch at index 4: Inputs = ["16'b1111111111111111" "20'b00000000000000000000"], Generated = ['sum'], Reference = ["20'b00001111111111111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 16'b1111111111111111, 20'b00000000000000000001, Generated = sum, Reference = 20'b00010000000000000000
        a = 16'b1111111111111111; b = 20'b00000000000000000001; // Set input values
        #period;
        if (!(sum === 20'b00010000000000000000)) begin
            $display("Mismatch at index 5: Inputs = ["16'b1111111111111111" "20'b00000000000000000001"], Generated = ['sum'], Reference = ["20'b00010000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 16'b1111111111111111, 20'b00101100110011000001, Generated = sum, Reference = 20'b00111100110011000000
        a = 16'b1111111111111111; b = 20'b00101100110011000001; // Set input values
        #period;
        if (!(sum === 20'b00111100110011000000)) begin
            $display("Mismatch at index 6: Inputs = ["16'b1111111111111111" "20'b00101100110011000001"], Generated = ['sum'], Reference = ["20'b00111100110011000000"]");
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