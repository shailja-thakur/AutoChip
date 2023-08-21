`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [7:0] code;

    wire [3:0] out;
    wire valid;


    integer mismatch_count;

    top_module UUT (.code(code), .out(out), .valid(valid));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b1000101, Generated = out, valid, Reference = 1'b0, 1'b1
        code = 1'b1000101; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b1)) begin
            $display("Mismatch at index 0: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1000101, out, valid, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b1000101, Generated = out, valid, Reference = 1'b0, 1'b1
        code = 1'b1000101; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b1)) begin
            $display("Mismatch at index 1: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1000101, out, valid, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b1000101, Generated = out, valid, Reference = 1'b0, 1'b1
        code = 1'b1000101; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b1)) begin
            $display("Mismatch at index 2: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1000101, out, valid, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b11, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b11; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 3: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b11, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b11, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b11; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 4: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b11, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b110, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b110; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 5: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b110, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b110, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b110; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 6: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b110, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b10110, Generated = out, valid, Reference = 1'b1, 1'b1
        code = 1'b10110; // Set input values
        #period;
        if (!(out === 1'b1 && valid === 1'b1)) begin
            $display("Mismatch at index 7: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b10110, out, valid, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b10110, Generated = out, valid, Reference = 1'b1, 1'b1
        code = 1'b10110; // Set input values
        #period;
        if (!(out === 1'b1 && valid === 1'b1)) begin
            $display("Mismatch at index 8: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b10110, out, valid, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b11010, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b11010; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 9: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b11010, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 1'b11010, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b11010; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 10: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b11010, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 1'b11110, Generated = out, valid, Reference = 1'b10, 1'b1
        code = 1'b11110; // Set input values
        #period;
        if (!(out === 1'b10 && valid === 1'b1)) begin
            $display("Mismatch at index 11: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b11110, out, valid, 1'b10, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 1'b11110, Generated = out, valid, Reference = 1'b10, 1'b1
        code = 1'b11110; // Set input values
        #period;
        if (!(out === 1'b10 && valid === 1'b1)) begin
            $display("Mismatch at index 12: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b11110, out, valid, 1'b10, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 1'b100101, Generated = out, valid, Reference = 1'b100, 1'b1
        code = 1'b100101; // Set input values
        #period;
        if (!(out === 1'b100 && valid === 1'b1)) begin
            $display("Mismatch at index 13: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b100101, out, valid, 1'b100, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 1'b100101, Generated = out, valid, Reference = 1'b100, 1'b1
        code = 1'b100101; // Set input values
        #period;
        if (!(out === 1'b100 && valid === 1'b1)) begin
            $display("Mismatch at index 14: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b100101, out, valid, 1'b100, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 1'b100110, Generated = out, valid, Reference = 1'b11, 1'b1
        code = 1'b100110; // Set input values
        #period;
        if (!(out === 1'b11 && valid === 1'b1)) begin
            $display("Mismatch at index 15: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b100110, out, valid, 1'b11, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 1'b100110, Generated = out, valid, Reference = 1'b11, 1'b1
        code = 1'b100110; // Set input values
        #period;
        if (!(out === 1'b11 && valid === 1'b1)) begin
            $display("Mismatch at index 16: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b100110, out, valid, 1'b11, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 1'b101110, Generated = out, valid, Reference = 1'b101, 1'b1
        code = 1'b101110; // Set input values
        #period;
        if (!(out === 1'b101 && valid === 1'b1)) begin
            $display("Mismatch at index 17: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b101110, out, valid, 1'b101, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 1'b101110, Generated = out, valid, Reference = 1'b101, 1'b1
        code = 1'b101110; // Set input values
        #period;
        if (!(out === 1'b101 && valid === 1'b1)) begin
            $display("Mismatch at index 18: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b101110, out, valid, 1'b101, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = 1'b100100, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b100100; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 19: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b100100, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = 1'b100100, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b100100; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 20: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b100100, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = 1'b110110, Generated = out, valid, Reference = 1'b110, 1'b1
        code = 1'b110110; // Set input values
        #period;
        if (!(out === 1'b110 && valid === 1'b1)) begin
            $display("Mismatch at index 21: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b110110, out, valid, 1'b110, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 21 passed!");
        end

        // Tick 22: Inputs = 1'b110110, Generated = out, valid, Reference = 1'b110, 1'b1
        code = 1'b110110; // Set input values
        #period;
        if (!(out === 1'b110 && valid === 1'b1)) begin
            $display("Mismatch at index 22: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b110110, out, valid, 1'b110, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 22 passed!");
        end

        // Tick 23: Inputs = 1'b10000001, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b10000001; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 23: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b10000001, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 23 passed!");
        end

        // Tick 24: Inputs = 1'b10000001, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b10000001; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 24: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b10000001, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 24 passed!");
        end

        // Tick 25: Inputs = 1'b111101, Generated = out, valid, Reference = 1'b111, 1'b1
        code = 1'b111101; // Set input values
        #period;
        if (!(out === 1'b111 && valid === 1'b1)) begin
            $display("Mismatch at index 25: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b111101, out, valid, 1'b111, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 25 passed!");
        end

        // Tick 26: Inputs = 1'b111101, Generated = out, valid, Reference = 1'b111, 1'b1
        code = 1'b111101; // Set input values
        #period;
        if (!(out === 1'b111 && valid === 1'b1)) begin
            $display("Mismatch at index 26: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b111101, out, valid, 1'b111, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 26 passed!");
        end

        // Tick 27: Inputs = 1'b111110, Generated = out, valid, Reference = 1'b1000, 1'b1
        code = 1'b111110; // Set input values
        #period;
        if (!(out === 1'b1000 && valid === 1'b1)) begin
            $display("Mismatch at index 27: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b111110, out, valid, 1'b1000, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 27 passed!");
        end

        // Tick 28: Inputs = 1'b111110, Generated = out, valid, Reference = 1'b1000, 1'b1
        code = 1'b111110; // Set input values
        #period;
        if (!(out === 1'b1000 && valid === 1'b1)) begin
            $display("Mismatch at index 28: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b111110, out, valid, 1'b1000, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 28 passed!");
        end

        // Tick 29: Inputs = 1'b1000101, Generated = out, valid, Reference = 1'b0, 1'b1
        code = 1'b1000101; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b1)) begin
            $display("Mismatch at index 29: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1000101, out, valid, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 29 passed!");
        end

        // Tick 30: Inputs = 1'b1000101, Generated = out, valid, Reference = 1'b0, 1'b1
        code = 1'b1000101; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b1)) begin
            $display("Mismatch at index 30: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1000101, out, valid, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 30 passed!");
        end

        // Tick 31: Inputs = 1'b1000110, Generated = out, valid, Reference = 1'b1001, 1'b1
        code = 1'b1000110; // Set input values
        #period;
        if (!(out === 1'b1001 && valid === 1'b1)) begin
            $display("Mismatch at index 31: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1000110, out, valid, 1'b1001, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 31 passed!");
        end

        // Tick 32: Inputs = 1'b1000110, Generated = out, valid, Reference = 1'b1001, 1'b1
        code = 1'b1000110; // Set input values
        #period;
        if (!(out === 1'b1001 && valid === 1'b1)) begin
            $display("Mismatch at index 32: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1000110, out, valid, 1'b1001, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 32 passed!");
        end

        // Tick 33: Inputs = 1'b1001, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b1001; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 33: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1001, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 33 passed!");
        end

        // Tick 34: Inputs = 1'b1001, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b1001; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 34: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1001, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 34 passed!");
        end

        // Tick 35: Inputs = 1'b1100011, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b1100011; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 35: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1100011, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 35 passed!");
        end

        // Tick 36: Inputs = 1'b1100011, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b1100011; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 36: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1100011, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 36 passed!");
        end

        // Tick 37: Inputs = 1'b1101, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b1101; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 37: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1101, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 37 passed!");
        end

        // Tick 38: Inputs = 1'b1101, Generated = out, valid, Reference = 1'b0, 1'b0
        code = 1'b1101; // Set input values
        #period;
        if (!(out === 1'b0 && valid === 1'b0)) begin
            $display("Mismatch at index 38: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1101, out, valid, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 38 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 39);
        $finish;
    end

endmodule