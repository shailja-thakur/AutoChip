`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [3:0] a;
    reg [3:0] b;
    reg [3:0] c;
    reg [3:0] d;
    reg [3:0] e;

    wire [3:0] q;


    integer mismatch_count;

    top_module UUT (.a(a), .b(b), .c(c), .d(d), .e(e), .q(q));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 4'b000x, 4'b000x, 4'b000x, 4'b000x, 4'b000x, Generated = q, Reference = 4'b000x
        a = 4'b000x; b = 4'b000x; c = 4'b000x; d = 4'b000x; e = 4'b000x; // Set input values
        #period;
        // Tick 1: Inputs = 4'b1010, 4'b1011, 4'b0000, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1011
        a = 4'b1010; b = 4'b1011; c = 4'b0000; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1011)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b0000, 4'b1101, 4'b1110, q, 4'b1011);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 4'b1010, 4'b1011, 4'b0001, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1110
        a = 4'b1010; b = 4'b1011; c = 4'b0001; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1110)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b0001, 4'b1101, 4'b1110, q, 4'b1110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 4'b1010, 4'b1011, 4'b0010, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1010
        a = 4'b1010; b = 4'b1011; c = 4'b0010; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1010)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b0010, 4'b1101, 4'b1110, q, 4'b1010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 4'b1010, 4'b1011, 4'b0011, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1101
        a = 4'b1010; b = 4'b1011; c = 4'b0011; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1101)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b0011, 4'b1101, 4'b1110, q, 4'b1101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 4'b1010, 4'b1011, 4'b0100, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b0100; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b0100, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 4'b1010, 4'b1011, 4'b0101, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b0101; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b0101, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 4'b1010, 4'b1011, 4'b0110, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b0110; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b0110, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 4'b1010, 4'b1011, 4'b0111, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b0111; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 8: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b0111, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 4'b1010, 4'b1011, 4'b1000, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b1000; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 9: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b1000, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 4'b1010, 4'b1011, 4'b1001, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b1001; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 10: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b1001, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 4'b1010, 4'b1011, 4'b1010, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b1010; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 11: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b1010, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 4'b1010, 4'b1011, 4'b1011, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b1011; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 12: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b1011, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 4'b1010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 13: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 4'b1010, 4'b1011, 4'b1101, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b1101; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 14: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b1101, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 4'b1010, 4'b1011, 4'b1110, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b1110; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 15: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b1110, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 4'b1010, 4'b1011, 4'b1111, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1111
        a = 4'b1010; b = 4'b1011; c = 4'b1111; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1111)) begin
            $display("Mismatch at index 16: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b1111, 4'b1101, 4'b1110, q, 4'b1111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 4'b1010, 4'b1011, 4'b0000, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1011
        a = 4'b1010; b = 4'b1011; c = 4'b0000; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1011)) begin
            $display("Mismatch at index 17: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b0000, 4'b1101, 4'b1110, q, 4'b1011);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 4'b1010, 4'b1011, 4'b0001, 4'b1101, 4'b1110, Generated = q, Reference = 4'b1110
        a = 4'b1010; b = 4'b1011; c = 4'b0001; d = 4'b1101; e = 4'b1110; // Set input values
        #period;
        if (!(q === 4'b1110)) begin
            $display("Mismatch at index 18: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 4'b1010, 4'b1011, 4'b0001, 4'b1101, 4'b1110, q, 4'b1110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 18 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 19);
        $finish;
    end

endmodule