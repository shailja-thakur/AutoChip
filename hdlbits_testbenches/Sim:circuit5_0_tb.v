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

        // Tick 0: Inputs = 1'b1010, 1'b1011, 1'b10, 1'b1101, 1'b1110, Generated = q, Reference = 1'b1010
        a = 1'b1010; b = 1'b1011; c = 1'b10; d = 1'b1101; e = 1'b1110; // Set input values
        #period;
        if (!(q === 1'b1010)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1010, 1'b1011, 1'b10, 1'b1101, 1'b1110, q, 1'b1010);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b1, 1'b10, 1'b0, 1'b11, 1'b100, Generated = q, Reference = 1'b10
        a = 1'b1; b = 1'b10; c = 1'b0; d = 1'b11; e = 1'b100; // Set input values
        #period;
        if (!(q === 1'b10)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b0, 1'b11, 1'b100, q, 1'b10);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b1, 1'b10, 1'b1, 1'b11, 1'b100, Generated = q, Reference = 1'b100
        a = 1'b1; b = 1'b10; c = 1'b1; d = 1'b11; e = 1'b100; // Set input values
        #period;
        if (!(q === 1'b100)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b1, 1'b11, 1'b100, q, 1'b100);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b1, 1'b10, 1'b10, 1'b11, 1'b100, Generated = q, Reference = 1'b1
        a = 1'b1; b = 1'b10; c = 1'b10; d = 1'b11; e = 1'b100; // Set input values
        #period;
        if (!(q === 1'b1)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b10, 1'b11, 1'b100, q, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b1, 1'b10, 1'b11, 1'b11, 1'b100, Generated = q, Reference = 1'b11
        a = 1'b1; b = 1'b10; c = 1'b11; d = 1'b11; e = 1'b100; // Set input values
        #period;
        if (!(q === 1'b11)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b11, 1'b11, 1'b100, q, 1'b11);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b1, 1'b10, 1'b100, 1'b11, 1'b100, Generated = q, Reference = 1'b1111
        a = 1'b1; b = 1'b10; c = 1'b100; d = 1'b11; e = 1'b100; // Set input values
        #period;
        if (!(q === 1'b1111)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b100, 1'b11, 1'b100, q, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b1, 1'b10, 1'b101, 1'b11, 1'b100, Generated = q, Reference = 1'b1111
        a = 1'b1; b = 1'b10; c = 1'b101; d = 1'b11; e = 1'b100; // Set input values
        #period;
        if (!(q === 1'b1111)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b101, 1'b11, 1'b100, q, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b1, 1'b10, 1'b110, 1'b11, 1'b100, Generated = q, Reference = 1'b1111
        a = 1'b1; b = 1'b10; c = 1'b110; d = 1'b11; e = 1'b100; // Set input values
        #period;
        if (!(q === 1'b1111)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b110, 1'b11, 1'b100, q, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b1, 1'b10, 1'b111, 1'b11, 1'b100, Generated = q, Reference = 1'b1111
        a = 1'b1; b = 1'b10; c = 1'b111; d = 1'b11; e = 1'b100; // Set input values
        #period;
        if (!(q === 1'b1111)) begin
            $display("Mismatch at index 8: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b111, 1'b11, 1'b100, q, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b1, 1'b10, 1'b1000, 1'b11, 1'b100, Generated = q, Reference = 1'b1111
        a = 1'b1; b = 1'b10; c = 1'b1000; d = 1'b11; e = 1'b100; // Set input values
        #period;
        if (!(q === 1'b1111)) begin
            $display("Mismatch at index 9: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b1000, 1'b11, 1'b100, q, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 1'b1, 1'b10, 1'b1000, 1'b11, 1'b100, Generated = q, Reference = 1'b1111
        a = 1'b1; b = 1'b10; c = 1'b1000; d = 1'b11; e = 1'b100; // Set input values
        #period;
        if (!(q === 1'b1111)) begin
            $display("Mismatch at index 10: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b1000, 1'b11, 1'b100, q, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 1'b101, 1'b110, 1'b0, 1'b111, 1'b1000, Generated = q, Reference = 1'b110
        a = 1'b101; b = 1'b110; c = 1'b0; d = 1'b111; e = 1'b1000; // Set input values
        #period;
        if (!(q === 1'b110)) begin
            $display("Mismatch at index 11: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b101, 1'b110, 1'b0, 1'b111, 1'b1000, q, 1'b110);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 1'b101, 1'b110, 1'b1, 1'b111, 1'b1000, Generated = q, Reference = 1'b1000
        a = 1'b101; b = 1'b110; c = 1'b1; d = 1'b111; e = 1'b1000; // Set input values
        #period;
        if (!(q === 1'b1000)) begin
            $display("Mismatch at index 12: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b101, 1'b110, 1'b1, 1'b111, 1'b1000, q, 1'b1000);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 1'b101, 1'b110, 1'b10, 1'b111, 1'b1000, Generated = q, Reference = 1'b101
        a = 1'b101; b = 1'b110; c = 1'b10; d = 1'b111; e = 1'b1000; // Set input values
        #period;
        if (!(q === 1'b101)) begin
            $display("Mismatch at index 13: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b101, 1'b110, 1'b10, 1'b111, 1'b1000, q, 1'b101);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 1'b101, 1'b110, 1'b11, 1'b111, 1'b1000, Generated = q, Reference = 1'b111
        a = 1'b101; b = 1'b110; c = 1'b11; d = 1'b111; e = 1'b1000; // Set input values
        #period;
        if (!(q === 1'b111)) begin
            $display("Mismatch at index 14: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b101, 1'b110, 1'b11, 1'b111, 1'b1000, q, 1'b111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 1'b101, 1'b110, 1'b100, 1'b111, 1'b1000, Generated = q, Reference = 1'b1111
        a = 1'b101; b = 1'b110; c = 1'b100; d = 1'b111; e = 1'b1000; // Set input values
        #period;
        if (!(q === 1'b1111)) begin
            $display("Mismatch at index 15: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b101, 1'b110, 1'b100, 1'b111, 1'b1000, q, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 1'b101, 1'b110, 1'b101, 1'b111, 1'b1000, Generated = q, Reference = 1'b1111
        a = 1'b101; b = 1'b110; c = 1'b101; d = 1'b111; e = 1'b1000; // Set input values
        #period;
        if (!(q === 1'b1111)) begin
            $display("Mismatch at index 16: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b101, 1'b110, 1'b101, 1'b111, 1'b1000, q, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 1'b101, 1'b110, 1'b110, 1'b111, 1'b1000, Generated = q, Reference = 1'b1111
        a = 1'b101; b = 1'b110; c = 1'b110; d = 1'b111; e = 1'b1000; // Set input values
        #period;
        if (!(q === 1'b1111)) begin
            $display("Mismatch at index 17: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b101, 1'b110, 1'b110, 1'b111, 1'b1000, q, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 1'b101, 1'b110, 1'b111, 1'b111, 1'b1000, Generated = q, Reference = 1'b1111
        a = 1'b101; b = 1'b110; c = 1'b111; d = 1'b111; e = 1'b1000; // Set input values
        #period;
        if (!(q === 1'b1111)) begin
            $display("Mismatch at index 18: Inputs = [%b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b101, 1'b110, 1'b111, 1'b111, 1'b1000, q, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
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