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

        // Tick 0: Inputs = 1'b0, Generated = q, Reference = 4'b1001000110010
        a = 1'b0; // Set input values
        #period;
        if (!(q === 4'b1001000110010)) begin
            $display("Mismatch at index 0: Inputs = [%b], Generated = [%b], Reference = [%b]", 1'b0, q, 4'b1001000110010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b1, Generated = q, Reference = 4'b1010111011100000
        a = 1'b1; // Set input values
        #period;
        if (!(q === 4'b1010111011100000)) begin
            $display("Mismatch at index 1: Inputs = [%b], Generated = [%b], Reference = [%b]", 1'b1, q, 4'b1010111011100000);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b10, Generated = q, Reference = 4'b10011111010100
        a = 1'b10; // Set input values
        #period;
        if (!(q === 4'b10011111010100)) begin
            $display("Mismatch at index 2: Inputs = [%b], Generated = [%b], Reference = [%b]", 1'b10, q, 4'b10011111010100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b11, Generated = q, Reference = 4'b101101000001110
        a = 1'b11; // Set input values
        #period;
        if (!(q === 4'b101101000001110)) begin
            $display("Mismatch at index 3: Inputs = [%b], Generated = [%b], Reference = [%b]", 1'b11, q, 4'b101101000001110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b100, Generated = q, Reference = 4'b10000001100110
        a = 1'b100; // Set input values
        #period;
        if (!(q === 4'b10000001100110)) begin
            $display("Mismatch at index 4: Inputs = [%b], Generated = [%b], Reference = [%b]", 1'b100, q, 4'b10000001100110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b101, Generated = q, Reference = 4'b110010011001110
        a = 1'b101; // Set input values
        #period;
        if (!(q === 4'b110010011001110)) begin
            $display("Mismatch at index 5: Inputs = [%b], Generated = [%b], Reference = [%b]", 1'b101, q, 4'b110010011001110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b110, Generated = q, Reference = 4'b1100010100100110
        a = 1'b110; // Set input values
        #period;
        if (!(q === 4'b1100010100100110)) begin
            $display("Mismatch at index 6: Inputs = [%b], Generated = [%b], Reference = [%b]", 1'b110, q, 4'b1100010100100110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b111, Generated = q, Reference = 4'b10111100011001
        a = 1'b111; // Set input values
        #period;
        if (!(q === 4'b10111100011001)) begin
            $display("Mismatch at index 7: Inputs = [%b], Generated = [%b], Reference = [%b]", 1'b111, q, 4'b10111100011001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b0, Generated = q, Reference = 4'b1001000110010
        a = 1'b0; // Set input values
        #period;
        if (!(q === 4'b1001000110010)) begin
            $display("Mismatch at index 8: Inputs = [%b], Generated = [%b], Reference = [%b]", 1'b0, q, 4'b1001000110010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b1, Generated = q, Reference = 4'b1010111011100000
        a = 1'b1; // Set input values
        #period;
        if (!(q === 4'b1010111011100000)) begin
            $display("Mismatch at index 9: Inputs = [%b], Generated = [%b], Reference = [%b]", 1'b1, q, 4'b1010111011100000);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 10);
        $finish;
    end

endmodule