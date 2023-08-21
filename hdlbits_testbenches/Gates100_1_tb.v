`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [99:0] in;

    wire out_and;
    wire out_or;
    wire out_xor;


    integer mismatch_count;

    top_module UUT (.in(in), .out_and(out_and), .out_or(out_or), .out_xor(out_xor));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b0, 1'b0
        in = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b0 && out_xor === 1'b0)) begin
            $display("Mismatch at index 0: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, out_and, out_or, out_xor, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b0, 1'b0
        in = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b0 && out_xor === 1'b0)) begin
            $display("Mismatch at index 1: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, out_and, out_or, out_xor, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111, Generated = out_and, out_or, out_xor, Reference = 1'b1, 1'b1, 1'b0
        in = 100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111; // Set input values
        #period;
        if (!(out_and === 1'b1 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 2: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111, out_and, out_or, out_xor, 1'b1, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 3: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111000000000000000000, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b0
        in = 100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111000000000000000000; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b0)) begin
            $display("Mismatch at index 4: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111000000000000000000, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000, Generated = out_and, out_or, out_xor, Reference = 1'b0, 1'b1, 1'b1
        in = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000; // Set input values
        #period;
        if (!(out_and === 1'b0 && out_or === 1'b1 && out_xor === 1'b1)) begin
            $display("Mismatch at index 5: Inputs = [%b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000, out_and, out_or, out_xor, 1'b0, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
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