`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [1:0] sel;
    reg [7:0] a;
    reg [7:0] b;
    reg [7:0] c;
    reg [7:0] d;

    wire [7:0] out;


    integer mismatch_count;

    top_module UUT (.sel(sel), .a(a), .b(b), .c(c), .d(d), .out(out));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 4'b0000, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, Generated = out, Reference = 16'b0000000010101010
        sel = 4'b0000; a = 16'b0000000010101010; b = 16'b0000000010111011; c = 16'b0000000011001100; d = 16'b0000000011011101; // Set input values
        #period;
        if (!(out === 16'b0000000010101010)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0000, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, out, 16'b0000000010101010);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 4'b0000, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, Generated = out, Reference = 16'b0000000010101010
        sel = 4'b0000; a = 16'b0000000010101010; b = 16'b0000000010111011; c = 16'b0000000011001100; d = 16'b0000000011011101; // Set input values
        #period;
        if (!(out === 16'b0000000010101010)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0000, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, out, 16'b0000000010101010);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 4'b0000, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, Generated = out, Reference = 16'b0000000010101010
        sel = 4'b0000; a = 16'b0000000010101010; b = 16'b0000000010111011; c = 16'b0000000011001100; d = 16'b0000000011011101; // Set input values
        #period;
        if (!(out === 16'b0000000010101010)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0000, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, out, 16'b0000000010101010);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 4'b0000, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, Generated = out, Reference = 16'b0000000010101010
        sel = 4'b0000; a = 16'b0000000010101010; b = 16'b0000000010111011; c = 16'b0000000011001100; d = 16'b0000000011011101; // Set input values
        #period;
        if (!(out === 16'b0000000010101010)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0000, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, out, 16'b0000000010101010);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 4'b0001, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, Generated = out, Reference = 16'b0000000010111011
        sel = 4'b0001; a = 16'b0000000010101010; b = 16'b0000000010111011; c = 16'b0000000011001100; d = 16'b0000000011011101; // Set input values
        #period;
        if (!(out === 16'b0000000010111011)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0001, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, out, 16'b0000000010111011);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 4'b0010, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, Generated = out, Reference = 16'b0000000011001100
        sel = 4'b0010; a = 16'b0000000010101010; b = 16'b0000000010111011; c = 16'b0000000011001100; d = 16'b0000000011011101; // Set input values
        #period;
        if (!(out === 16'b0000000011001100)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0010, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, out, 16'b0000000011001100);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 4'b0011, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, Generated = out, Reference = 16'b0000000011011101
        sel = 4'b0011; a = 16'b0000000010101010; b = 16'b0000000010111011; c = 16'b0000000011001100; d = 16'b0000000011011101; // Set input values
        #period;
        if (!(out === 16'b0000000011011101)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0011, 16'b0000000010101010, 16'b0000000010111011, 16'b0000000011001100, 16'b0000000011011101, out, 16'b0000000011011101);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 4'b0000, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, Generated = out, Reference = 16'b0000000001111111
        sel = 4'b0000; a = 16'b0000000001111111; b = 16'b0000000000000000; c = 16'b0000000001010101; d = 16'b0000000000101010; // Set input values
        #period;
        if (!(out === 16'b0000000001111111)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0000, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, out, 16'b0000000001111111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 4'b0000, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, Generated = out, Reference = 16'b0000000001111111
        sel = 4'b0000; a = 16'b0000000001111111; b = 16'b0000000000000000; c = 16'b0000000001010101; d = 16'b0000000000101010; // Set input values
        #period;
        if (!(out === 16'b0000000001111111)) begin
            $display("Mismatch at index 8: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0000, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, out, 16'b0000000001111111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 4'b0000, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, Generated = out, Reference = 16'b0000000001111111
        sel = 4'b0000; a = 16'b0000000001111111; b = 16'b0000000000000000; c = 16'b0000000001010101; d = 16'b0000000000101010; // Set input values
        #period;
        if (!(out === 16'b0000000001111111)) begin
            $display("Mismatch at index 9: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0000, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, out, 16'b0000000001111111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 4'b0000, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, Generated = out, Reference = 16'b0000000001111111
        sel = 4'b0000; a = 16'b0000000001111111; b = 16'b0000000000000000; c = 16'b0000000001010101; d = 16'b0000000000101010; // Set input values
        #period;
        if (!(out === 16'b0000000001111111)) begin
            $display("Mismatch at index 10: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0000, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, out, 16'b0000000001111111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 4'b0001, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, Generated = out, Reference = 16'b0000000000000000
        sel = 4'b0001; a = 16'b0000000001111111; b = 16'b0000000000000000; c = 16'b0000000001010101; d = 16'b0000000000101010; // Set input values
        #period;
        if (!(out === 16'b0000000000000000)) begin
            $display("Mismatch at index 11: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0001, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, out, 16'b0000000000000000);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 4'b0010, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, Generated = out, Reference = 16'b0000000001010101
        sel = 4'b0010; a = 16'b0000000001111111; b = 16'b0000000000000000; c = 16'b0000000001010101; d = 16'b0000000000101010; // Set input values
        #period;
        if (!(out === 16'b0000000001010101)) begin
            $display("Mismatch at index 12: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0010, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, out, 16'b0000000001010101);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 4'b0011, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, Generated = out, Reference = 16'b0000000000101010
        sel = 4'b0011; a = 16'b0000000001111111; b = 16'b0000000000000000; c = 16'b0000000001010101; d = 16'b0000000000101010; // Set input values
        #period;
        if (!(out === 16'b0000000000101010)) begin
            $display("Mismatch at index 13: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b0011, 16'b0000000001111111, 16'b0000000000000000, 16'b0000000001010101, 16'b0000000000101010, out, 16'b0000000000101010);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 14);
        $finish;
    end

endmodule