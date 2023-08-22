`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [2:0] a;

    wire [15:0] q;


    integer mismatch_count;

    top_module UUT (.a(a), .q(q));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 3'b00x, Generated = q, Reference = 16'b000000000000000x
        a = 3'b00x; // Set input values
        #period;
        // Tick 1: Inputs = 3'b000, Generated = q, Reference = 16'b0001001000110010
        a = 3'b000; // Set input values
        #period;
        if (!(q === 16'b0001001000110010)) begin
            $display("Mismatch at index 1: Inputs = [%b], Generated = [%b], Reference = [%b]", 3'b000, q, 16'b0001001000110010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 3'b001, Generated = q, Reference = 16'b1010111011100000
        a = 3'b001; // Set input values
        #period;
        if (!(q === 16'b1010111011100000)) begin
            $display("Mismatch at index 2: Inputs = [%b], Generated = [%b], Reference = [%b]", 3'b001, q, 16'b1010111011100000);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 3'b010, Generated = q, Reference = 16'b0010011111010100
        a = 3'b010; // Set input values
        #period;
        if (!(q === 16'b0010011111010100)) begin
            $display("Mismatch at index 3: Inputs = [%b], Generated = [%b], Reference = [%b]", 3'b010, q, 16'b0010011111010100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 3'b011, Generated = q, Reference = 16'b0101101000001110
        a = 3'b011; // Set input values
        #period;
        if (!(q === 16'b0101101000001110)) begin
            $display("Mismatch at index 4: Inputs = [%b], Generated = [%b], Reference = [%b]", 3'b011, q, 16'b0101101000001110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 3'b100, Generated = q, Reference = 16'b0010000001100110
        a = 3'b100; // Set input values
        #period;
        if (!(q === 16'b0010000001100110)) begin
            $display("Mismatch at index 5: Inputs = [%b], Generated = [%b], Reference = [%b]", 3'b100, q, 16'b0010000001100110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 3'b101, Generated = q, Reference = 16'b0110010011001110
        a = 3'b101; // Set input values
        #period;
        if (!(q === 16'b0110010011001110)) begin
            $display("Mismatch at index 6: Inputs = [%b], Generated = [%b], Reference = [%b]", 3'b101, q, 16'b0110010011001110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 3'b110, Generated = q, Reference = 16'b1100010100100110
        a = 3'b110; // Set input values
        #period;
        if (!(q === 16'b1100010100100110)) begin
            $display("Mismatch at index 7: Inputs = [%b], Generated = [%b], Reference = [%b]", 3'b110, q, 16'b1100010100100110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 3'b111, Generated = q, Reference = 16'b0010111100011001
        a = 3'b111; // Set input values
        #period;
        if (!(q === 16'b0010111100011001)) begin
            $display("Mismatch at index 8: Inputs = [%b], Generated = [%b], Reference = [%b]", 3'b111, q, 16'b0010111100011001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 3'b000, Generated = q, Reference = 16'b0001001000110010
        a = 3'b000; // Set input values
        #period;
        if (!(q === 16'b0001001000110010)) begin
            $display("Mismatch at index 9: Inputs = [%b], Generated = [%b], Reference = [%b]", 3'b000, q, 16'b0001001000110010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 3'b001, Generated = q, Reference = 16'b1010111011100000
        a = 3'b001; // Set input values
        #period;
        if (!(q === 16'b1010111011100000)) begin
            $display("Mismatch at index 10: Inputs = [%b], Generated = [%b], Reference = [%b]", 3'b001, q, 16'b1010111011100000);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 10 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 11);
        $finish;
    end

endmodule