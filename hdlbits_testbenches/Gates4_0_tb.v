`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [3:0] in;

    wire out_and;
    wire out_or;
    wire out_xor;


    integer mismatch_count;

    top_module UUT (.in(in), .out_and(out_and), .out_or(out_or), .out_xor(out_xor));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 8'b00000000, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b0, 1'b0
        in = 8'b00000000; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b0 && out_xor === 1'b0)) begin
            $display("Mismatch at index 0: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000000, out_and, out_or, out_xor, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 8'b00000000, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b0, 1'b0
        in = 8'b00000000; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b0 && out_xor === 1'b0)) begin
            $display("Mismatch at index 1: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000000, out_and, out_or, out_xor, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 8'b00000000, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b0, 1'b0
        in = 8'b00000000; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b0 && out_xor === 1'b0)) begin
            $display("Mismatch at index 2: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000000, out_and, out_or, out_xor, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 8'b00000001, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00000001; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 3: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000001, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 8'b00000001, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00000001; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 4: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000001, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 8'b00000010, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00000010; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 5: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000010, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 8'b00000010, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00000010; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 6: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000010, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 8'b00000011, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00000011; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 7: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000011, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 8'b00000011, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00000011; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 8: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000011, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 8'b00000100, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00000100; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 9: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000100, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 8'b00000100, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00000100; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 10: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000100, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 8'b00000101, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00000101; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 11: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000101, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 8'b00000101, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00000101; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 12: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000101, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 8'b00000110, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00000110; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 13: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000110, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 8'b00000110, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00000110; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 14: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000110, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 8'b00000111, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00000111; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 15: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000111, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 8'b00000111, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00000111; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 16: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00000111, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 8'b00001000, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00001000; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 17: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001000, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 8'b00001000, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00001000; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 18: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001000, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = 8'b00001001, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00001001; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 19: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001001, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = 8'b00001001, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00001001; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 20: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001001, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = 8'b00001010, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00001010; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 21: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001010, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 21 passed!");
        end

        // Tick 22: Inputs = 8'b00001010, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00001010; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 22: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001010, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 22 passed!");
        end

        // Tick 23: Inputs = 8'b00001011, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00001011; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 23: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001011, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 23 passed!");
        end

        // Tick 24: Inputs = 8'b00001011, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00001011; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 24: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001011, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 24 passed!");
        end

        // Tick 25: Inputs = 8'b00001100, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00001100; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 25: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001100, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 25 passed!");
        end

        // Tick 26: Inputs = 8'b00001100, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 8'b00001100; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 26: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001100, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 26 passed!");
        end

        // Tick 27: Inputs = 8'b00001101, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00001101; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 27: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001101, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 27 passed!");
        end

        // Tick 28: Inputs = 8'b00001101, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00001101; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 28: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001101, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 28 passed!");
        end

        // Tick 29: Inputs = 8'b00001110, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00001110; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 29: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001110, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 29 passed!");
        end

        // Tick 30: Inputs = 8'b00001110, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 8'b00001110; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 30: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001110, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 30 passed!");
        end

        // Tick 31: Inputs = 8'b00001111, Generated = out_and, out_or, out_xor, Reference = 1'b1, 1'b1, 1'b0
        in = 8'b00001111; // Set input values
        #period;
        if (!(out_and === 1'b1 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 31: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 8'b00001111, out_and, out_or, out_xor, 1'b1, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 31 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 32);
        $finish;
    end

endmodule