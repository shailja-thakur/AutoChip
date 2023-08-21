`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [15:0] a;
    reg [15:0] b;
    reg [15:0] c;
    reg [15:0] d;
    reg [15:0] e;
    reg [15:0] f;
    reg [15:0] g;
    reg [15:0] h;
    reg [15:0] i;
    reg [3:0] sel;

    wire [15:0] out;


    integer mismatch_count;

    top_module UUT (.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h), .i(i), .sel(sel), .out(out));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b0, Generated = out, Reference = 1'b1010
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b0; // Set input values
        #period;
        if (!(out === 1'b1010)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b0, out, 1'b1010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1, Generated = out, Reference = 1'b1011
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b1; // Set input values
        #period;
        if (!(out === 1'b1011)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1, out, 1'b1011);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1, Generated = out, Reference = 1'b1011
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b1; // Set input values
        #period;
        if (!(out === 1'b1011)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1, out, 1'b1011);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b10, Generated = out, Reference = 1'b1100
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b10; // Set input values
        #period;
        if (!(out === 1'b1100)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b10, out, 1'b1100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b10, Generated = out, Reference = 1'b1100
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b10; // Set input values
        #period;
        if (!(out === 1'b1100)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b10, out, 1'b1100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b11, Generated = out, Reference = 1'b1101
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b11; // Set input values
        #period;
        if (!(out === 1'b1101)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b11, out, 1'b1101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b11, Generated = out, Reference = 1'b1101
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b11; // Set input values
        #period;
        if (!(out === 1'b1101)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b11, out, 1'b1101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b100, Generated = out, Reference = 1'b1110
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b100; // Set input values
        #period;
        if (!(out === 1'b1110)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b100, out, 1'b1110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b100, Generated = out, Reference = 1'b1110
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b100; // Set input values
        #period;
        if (!(out === 1'b1110)) begin
            $display("Mismatch at index 8: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b100, out, 1'b1110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b111, Generated = out, Reference = 1'b10010
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b111; // Set input values
        #period;
        if (!(out === 1'b10010)) begin
            $display("Mismatch at index 9: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b111, out, 1'b10010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b111, Generated = out, Reference = 1'b10010
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b111; // Set input values
        #period;
        if (!(out === 1'b10010)) begin
            $display("Mismatch at index 10: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b111, out, 1'b10010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1000, Generated = out, Reference = 1'b10011
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b1000; // Set input values
        #period;
        if (!(out === 1'b10011)) begin
            $display("Mismatch at index 11: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1000, out, 1'b10011);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1000, Generated = out, Reference = 1'b10011
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b1000; // Set input values
        #period;
        if (!(out === 1'b10011)) begin
            $display("Mismatch at index 12: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1000, out, 1'b10011);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1001, Generated = out, Reference = 1'b1111111111111111
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b1001; // Set input values
        #period;
        if (!(out === 1'b1111111111111111)) begin
            $display("Mismatch at index 13: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1001, out, 1'b1111111111111111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1001, Generated = out, Reference = 1'b1111111111111111
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b1001; // Set input values
        #period;
        if (!(out === 1'b1111111111111111)) begin
            $display("Mismatch at index 14: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1001, out, 1'b1111111111111111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1010, Generated = out, Reference = 1'b1111111111111111
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b1010; // Set input values
        #period;
        if (!(out === 1'b1111111111111111)) begin
            $display("Mismatch at index 15: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1010, out, 1'b1111111111111111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1010, Generated = out, Reference = 1'b1111111111111111
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b1010; // Set input values
        #period;
        if (!(out === 1'b1111111111111111)) begin
            $display("Mismatch at index 16: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1010, out, 1'b1111111111111111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1011, Generated = out, Reference = 1'b1111111111111111
        a = 1'b1010; b = 1'b1011; c = 1'b1100; d = 1'b1101; e = 1'b1110; f = 1'b1111; g = 1'b10001; h = 1'b10010; i = 1'b10011; sel = 1'b1011; // Set input values
        #period;
        if (!(out === 1'b1111111111111111)) begin
            $display("Mismatch at index 17: Inputs = [%b, %b, %b, %b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, 1'b10001, 1'b10010, 1'b10011, 1'b1011, out, 1'b1111111111111111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 17 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 18);
        $finish;
    end

endmodule