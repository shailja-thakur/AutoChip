module top_module_tb;

    reg [14:0] in;

    wire [6:0] out_hi;
    wire [6:0] out_lo;


    top_module UUT (.in(in), .out_hi(out_hi), .out_lo(out_lo));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 15'b011010100100100, Generated = out_hi, out_lo, Reference = 7'b0110101, 7'b0100100
        in = 15'b011010100100100; // Set input values
        #period;
        if (!(out_hi === 7'b0110101 && out_lo === 7'b0100100)) begin
            $display("Mismatch at index 0: Inputs = ["15'b011010100100100"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b0110101", "7'b0100100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 15'b101111010000001, Generated = out_hi, out_lo, Reference = 7'b1011110, 7'b10000001
        in = 15'b101111010000001; // Set input values
        #period;
        if (!(out_hi === 7'b1011110 && out_lo === 7'b10000001)) begin
            $display("Mismatch at index 1: Inputs = ["15'b101111010000001"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b1011110", "7'b10000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 15'b1101011000001001, Generated = out_hi, out_lo, Reference = 7'b11010110, 7'b0001001
        in = 15'b1101011000001001; // Set input values
        #period;
        if (!(out_hi === 7'b11010110 && out_lo === 7'b0001001)) begin
            $display("Mismatch at index 2: Inputs = ["15'b1101011000001001"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b11010110", "7'b0001001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 15'b101011001100011, Generated = out_hi, out_lo, Reference = 7'b1010110, 7'b1100011
        in = 15'b101011001100011; // Set input values
        #period;
        if (!(out_hi === 7'b1010110 && out_lo === 7'b1100011)) begin
            $display("Mismatch at index 3: Inputs = ["15'b101011001100011"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b1010110", "7'b1100011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 15'b111101100001101, Generated = out_hi, out_lo, Reference = 7'b1111011, 7'b0001101
        in = 15'b111101100001101; // Set input values
        #period;
        if (!(out_hi === 7'b1111011 && out_lo === 7'b0001101)) begin
            $display("Mismatch at index 4: Inputs = ["15'b111101100001101"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b1111011", "7'b0001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 15'b1001100110001101, Generated = out_hi, out_lo, Reference = 7'b10011001, 7'b10001101
        in = 15'b1001100110001101; // Set input values
        #period;
        if (!(out_hi === 7'b10011001 && out_lo === 7'b10001101)) begin
            $display("Mismatch at index 5: Inputs = ["15'b1001100110001101"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b10011001", "7'b10001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 15'b1000010001100101, Generated = out_hi, out_lo, Reference = 7'b10000100, 7'b1100101
        in = 15'b1000010001100101; // Set input values
        #period;
        if (!(out_hi === 7'b10000100 && out_lo === 7'b1100101)) begin
            $display("Mismatch at index 6: Inputs = ["15'b1000010001100101"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b10000100", "7'b1100101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 15'b101001000010010, Generated = out_hi, out_lo, Reference = 7'b1010010, 7'b0010010
        in = 15'b101001000010010; // Set input values
        #period;
        if (!(out_hi === 7'b1010010 && out_lo === 7'b0010010)) begin
            $display("Mismatch at index 7: Inputs = ["15'b101001000010010"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b1010010", "7'b0010010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 15'b1110001100000001, Generated = out_hi, out_lo, Reference = 7'b11100011, 7'b0000001
        in = 15'b1110001100000001; // Set input values
        #period;
        if (!(out_hi === 7'b11100011 && out_lo === 7'b0000001)) begin
            $display("Mismatch at index 8: Inputs = ["15'b1110001100000001"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b11100011", "7'b0000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 15'b1100110100001101, Generated = out_hi, out_lo, Reference = 7'b11001101, 7'b0001101
        in = 15'b1100110100001101; // Set input values
        #period;
        if (!(out_hi === 7'b11001101 && out_lo === 7'b0001101)) begin
            $display("Mismatch at index 9: Inputs = ["15'b1100110100001101"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b11001101", "7'b0001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 15'b1111000101110110, Generated = out_hi, out_lo, Reference = 7'b11110001, 7'b1110110
        in = 15'b1111000101110110; // Set input values
        #period;
        if (!(out_hi === 7'b11110001 && out_lo === 7'b1110110)) begin
            $display("Mismatch at index 10: Inputs = ["15'b1111000101110110"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b11110001", "7'b1110110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 15'b1100110100111101, Generated = out_hi, out_lo, Reference = 7'b11001101, 7'b0111101
        in = 15'b1100110100111101; // Set input values
        #period;
        if (!(out_hi === 7'b11001101 && out_lo === 7'b0111101)) begin
            $display("Mismatch at index 11: Inputs = ["15'b1100110100111101"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b11001101", "7'b0111101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 15'b101011111101101, Generated = out_hi, out_lo, Reference = 7'b1010111, 7'b11101101
        in = 15'b101011111101101; // Set input values
        #period;
        if (!(out_hi === 7'b1010111 && out_lo === 7'b11101101)) begin
            $display("Mismatch at index 12: Inputs = ["15'b101011111101101"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b1010111", "7'b11101101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 15'b1111011110001100, Generated = out_hi, out_lo, Reference = 7'b11110111, 7'b10001100
        in = 15'b1111011110001100; // Set input values
        #period;
        if (!(out_hi === 7'b11110111 && out_lo === 7'b10001100)) begin
            $display("Mismatch at index 13: Inputs = ["15'b1111011110001100"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b11110111", "7'b10001100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 15'b1110100111111001, Generated = out_hi, out_lo, Reference = 7'b11101001, 7'b11111001
        in = 15'b1110100111111001; // Set input values
        #period;
        if (!(out_hi === 7'b11101001 && out_lo === 7'b11111001)) begin
            $display("Mismatch at index 14: Inputs = ["15'b1110100111111001"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b11101001", "7'b11111001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 15'b010010011000110, Generated = out_hi, out_lo, Reference = 7'b0100100, 7'b11000110
        in = 15'b010010011000110; // Set input values
        #period;
        if (!(out_hi === 7'b0100100 && out_lo === 7'b11000110)) begin
            $display("Mismatch at index 15: Inputs = ["15'b010010011000110"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b0100100", "7'b11000110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 15'b1000010011000101, Generated = out_hi, out_lo, Reference = 7'b10000100, 7'b11000101
        in = 15'b1000010011000101; // Set input values
        #period;
        if (!(out_hi === 7'b10000100 && out_lo === 7'b11000101)) begin
            $display("Mismatch at index 16: Inputs = ["15'b1000010011000101"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b10000100", "7'b11000101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 15'b1101001010101010, Generated = out_hi, out_lo, Reference = 7'b11010010, 7'b10101010
        in = 15'b1101001010101010; // Set input values
        #period;
        if (!(out_hi === 7'b11010010 && out_lo === 7'b10101010)) begin
            $display("Mismatch at index 17: Inputs = ["15'b1101001010101010"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b11010010", "7'b10101010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 15'b1111011111100101, Generated = out_hi, out_lo, Reference = 7'b11110111, 7'b11100101
        in = 15'b1111011111100101; // Set input values
        #period;
        if (!(out_hi === 7'b11110111 && out_lo === 7'b11100101)) begin
            $display("Mismatch at index 18: Inputs = ["15'b1111011111100101"], Generated = ['out_hi', 'out_lo'], Reference = ["7'b11110111", "7'b11100101"]");
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