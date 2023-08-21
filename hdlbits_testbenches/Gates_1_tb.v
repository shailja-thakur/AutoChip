`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg in;

    wire out_and;
    wire out_or;
    wire out_xor;


    integer mismatch_count;

    top_module UUT (.in(in), .out_and(out_and), .out_or(out_or), .out_xor(out_xor));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101111111, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 1'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101111111; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 0: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101111111, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b0, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b0, 1'b0
        in = 1'b0; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b0 && out_xor === 1'b0)) begin
            $display("Mismatch at index 1: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, out_and, out_or, out_xor, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b0, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b0, 1'b0
        in = 1'b0; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b0 && out_xor === 1'b0)) begin
            $display("Mismatch at index 2: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, out_and, out_or, out_xor, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b111, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 1'b111; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 3: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b111, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b0, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b0, 1'b0
        in = 1'b0; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b0 && out_xor === 1'b0)) begin
            $display("Mismatch at index 4: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, out_and, out_or, out_xor, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b1, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 1'b1; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 5: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b10, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 1'b10; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 6: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b10, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b11, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 1'b11; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 7: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b11, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b100, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 1'b100; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 8: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b100, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b101, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 1'b101; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 9: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b101, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 1'b110, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 1'b110; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 10: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b110, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 1'b111, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 1'b111; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 11: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b111, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 1'b1000, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 1'b1000; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 12: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1000, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 1'b1001, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 1'b1001; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 13: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1001, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 1'b1001, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 1'b1001; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 14: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1001, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 1'b0, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b0, 1'b0
        in = 1'b0; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b0 && out_xor === 1'b0)) begin
            $display("Mismatch at index 15: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, out_and, out_or, out_xor, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 15 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 16);
        $finish;
    end

endmodule