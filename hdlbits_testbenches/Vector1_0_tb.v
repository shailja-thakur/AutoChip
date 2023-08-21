`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [15:0] in;

    wire [7:0] out_hi;
    wire [7:0] out_lo;


    integer mismatch_count;

    top_module UUT (.in(in), .out_hi(out_hi), .out_lo(out_lo));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b11010100100100, Generated = out_hi, out_lo, Reference = 1'b110101, 1'b100100
        in = 1'b11010100100100; // Set input values
        #period;
        if (!(out_hi === 1'b110101 && out_lo === 1'b100100)) begin
            $display("Mismatch at index 0: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b11010100100100, out_hi, out_lo, 1'b110101, 1'b100100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b101111010000001, Generated = out_hi, out_lo, Reference = 1'b1011110, 1'b10000001
        in = 1'b101111010000001; // Set input values
        #period;
        if (!(out_hi === 1'b1011110 && out_lo === 1'b10000001)) begin
            $display("Mismatch at index 1: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b101111010000001, out_hi, out_lo, 1'b1011110, 1'b10000001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b1101011000001001, Generated = out_hi, out_lo, Reference = 1'b11010110, 1'b1001
        in = 1'b1101011000001001; // Set input values
        #period;
        if (!(out_hi === 1'b11010110 && out_lo === 1'b1001)) begin
            $display("Mismatch at index 2: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1101011000001001, out_hi, out_lo, 1'b11010110, 1'b1001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b101011001100011, Generated = out_hi, out_lo, Reference = 1'b1010110, 1'b1100011
        in = 1'b101011001100011; // Set input values
        #period;
        if (!(out_hi === 1'b1010110 && out_lo === 1'b1100011)) begin
            $display("Mismatch at index 3: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b101011001100011, out_hi, out_lo, 1'b1010110, 1'b1100011);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b111101100001101, Generated = out_hi, out_lo, Reference = 1'b1111011, 1'b1101
        in = 1'b111101100001101; // Set input values
        #period;
        if (!(out_hi === 1'b1111011 && out_lo === 1'b1101)) begin
            $display("Mismatch at index 4: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b111101100001101, out_hi, out_lo, 1'b1111011, 1'b1101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b1001100110001101, Generated = out_hi, out_lo, Reference = 1'b10011001, 1'b10001101
        in = 1'b1001100110001101; // Set input values
        #period;
        if (!(out_hi === 1'b10011001 && out_lo === 1'b10001101)) begin
            $display("Mismatch at index 5: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1001100110001101, out_hi, out_lo, 1'b10011001, 1'b10001101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b1000010001100101, Generated = out_hi, out_lo, Reference = 1'b10000100, 1'b1100101
        in = 1'b1000010001100101; // Set input values
        #period;
        if (!(out_hi === 1'b10000100 && out_lo === 1'b1100101)) begin
            $display("Mismatch at index 6: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1000010001100101, out_hi, out_lo, 1'b10000100, 1'b1100101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b101001000010010, Generated = out_hi, out_lo, Reference = 1'b1010010, 1'b10010
        in = 1'b101001000010010; // Set input values
        #period;
        if (!(out_hi === 1'b1010010 && out_lo === 1'b10010)) begin
            $display("Mismatch at index 7: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b101001000010010, out_hi, out_lo, 1'b1010010, 1'b10010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b1110001100000001, Generated = out_hi, out_lo, Reference = 1'b11100011, 1'b1
        in = 1'b1110001100000001; // Set input values
        #period;
        if (!(out_hi === 1'b11100011 && out_lo === 1'b1)) begin
            $display("Mismatch at index 8: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1110001100000001, out_hi, out_lo, 1'b11100011, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b1100110100001101, Generated = out_hi, out_lo, Reference = 1'b11001101, 1'b1101
        in = 1'b1100110100001101; // Set input values
        #period;
        if (!(out_hi === 1'b11001101 && out_lo === 1'b1101)) begin
            $display("Mismatch at index 9: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1100110100001101, out_hi, out_lo, 1'b11001101, 1'b1101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 1'b1111000101110110, Generated = out_hi, out_lo, Reference = 1'b11110001, 1'b1110110
        in = 1'b1111000101110110; // Set input values
        #period;
        if (!(out_hi === 1'b11110001 && out_lo === 1'b1110110)) begin
            $display("Mismatch at index 10: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1111000101110110, out_hi, out_lo, 1'b11110001, 1'b1110110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 1'b1100110100111101, Generated = out_hi, out_lo, Reference = 1'b11001101, 1'b111101
        in = 1'b1100110100111101; // Set input values
        #period;
        if (!(out_hi === 1'b11001101 && out_lo === 1'b111101)) begin
            $display("Mismatch at index 11: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1100110100111101, out_hi, out_lo, 1'b11001101, 1'b111101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 1'b101011111101101, Generated = out_hi, out_lo, Reference = 1'b1010111, 1'b11101101
        in = 1'b101011111101101; // Set input values
        #period;
        if (!(out_hi === 1'b1010111 && out_lo === 1'b11101101)) begin
            $display("Mismatch at index 12: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b101011111101101, out_hi, out_lo, 1'b1010111, 1'b11101101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 1'b1111011110001100, Generated = out_hi, out_lo, Reference = 1'b11110111, 1'b10001100
        in = 1'b1111011110001100; // Set input values
        #period;
        if (!(out_hi === 1'b11110111 && out_lo === 1'b10001100)) begin
            $display("Mismatch at index 13: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1111011110001100, out_hi, out_lo, 1'b11110111, 1'b10001100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 1'b1110100111111001, Generated = out_hi, out_lo, Reference = 1'b11101001, 1'b11111001
        in = 1'b1110100111111001; // Set input values
        #period;
        if (!(out_hi === 1'b11101001 && out_lo === 1'b11111001)) begin
            $display("Mismatch at index 14: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1110100111111001, out_hi, out_lo, 1'b11101001, 1'b11111001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 1'b10010011000110, Generated = out_hi, out_lo, Reference = 1'b100100, 1'b11000110
        in = 1'b10010011000110; // Set input values
        #period;
        if (!(out_hi === 1'b100100 && out_lo === 1'b11000110)) begin
            $display("Mismatch at index 15: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b10010011000110, out_hi, out_lo, 1'b100100, 1'b11000110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 1'b1000010011000101, Generated = out_hi, out_lo, Reference = 1'b10000100, 1'b11000101
        in = 1'b1000010011000101; // Set input values
        #period;
        if (!(out_hi === 1'b10000100 && out_lo === 1'b11000101)) begin
            $display("Mismatch at index 16: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1000010011000101, out_hi, out_lo, 1'b10000100, 1'b11000101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 1'b1101001010101010, Generated = out_hi, out_lo, Reference = 1'b11010010, 1'b10101010
        in = 1'b1101001010101010; // Set input values
        #period;
        if (!(out_hi === 1'b11010010 && out_lo === 1'b10101010)) begin
            $display("Mismatch at index 17: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1101001010101010, out_hi, out_lo, 1'b11010010, 1'b10101010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 1'b1111011111100101, Generated = out_hi, out_lo, Reference = 1'b11110111, 1'b11100101
        in = 1'b1111011111100101; // Set input values
        #period;
        if (!(out_hi === 1'b11110111 && out_lo === 1'b11100101)) begin
            $display("Mismatch at index 18: Inputs = [%b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1111011111100101, out_hi, out_lo, 1'b11110111, 1'b11100101);
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