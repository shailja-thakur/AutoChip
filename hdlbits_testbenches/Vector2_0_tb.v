module top_module_tb;

    reg [30:0] in;

    wire [30:0] out;


    top_module UUT (.in(in), .out(out));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 31'b0010010000101010011010100100100, Generated = out, Reference = 31'b0100100001101010001010100010010
        in = 31'b0010010000101010011010100100100; // Set input values
        #period;
        if (!(out === 31'b0100100001101010001010100010010)) begin
            $display("Mismatch at index 0: Inputs = ["31'b0010010000101010011010100100100"], Generated = ['out'], Reference = ["31'b0100100001101010001010100010010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 31'b11000000100010010101111010000001, Generated = out, Reference = 31'b10000001010111101000100111000000
        in = 31'b11000000100010010101111010000001; // Set input values
        #period;
        if (!(out === 31'b10000001010111101000100111000000)) begin
            $display("Mismatch at index 1: Inputs = ["31'b11000000100010010101111010000001"], Generated = ['out'], Reference = ["31'b10000001010111101000100111000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 31'b10000100100001001101011000001001, Generated = out, Reference = 31'b0001001110101101000010010000100
        in = 31'b10000100100001001101011000001001; // Set input values
        #period;
        if (!(out === 31'b0001001110101101000010010000100)) begin
            $display("Mismatch at index 2: Inputs = ["31'b10000100100001001101011000001001"], Generated = ['out'], Reference = ["31'b0001001110101101000010010000100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 31'b10110001111100000101011001100011, Generated = out, Reference = 31'b1100011010101101111000010110001
        in = 31'b10110001111100000101011001100011; // Set input values
        #period;
        if (!(out === 31'b1100011010101101111000010110001)) begin
            $display("Mismatch at index 3: Inputs = ["31'b10110001111100000101011001100011"], Generated = ['out'], Reference = ["31'b1100011010101101111000010110001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 31'b0000110101110010111101100001101, Generated = out, Reference = 31'b0001101011110111011100100000110
        in = 31'b0000110101110010111101100001101; // Set input values
        #period;
        if (!(out === 31'b0001101011110111011100100000110)) begin
            $display("Mismatch at index 4: Inputs = ["31'b0000110101110010111101100001101"], Generated = ['out'], Reference = ["31'b0001101011110111011100100000110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 31'b1000110110111111001100110001101, Generated = out, Reference = 31'b10001101100110011101111101000110
        in = 31'b1000110110111111001100110001101; // Set input values
        #period;
        if (!(out === 31'b10001101100110011101111101000110)) begin
            $display("Mismatch at index 5: Inputs = ["31'b1000110110111111001100110001101"], Generated = ['out'], Reference = ["31'b10001101100110011101111101000110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 31'b10110010110000101000010001100101, Generated = out, Reference = 31'b1100101100001001100001010110010
        in = 31'b10110010110000101000010001100101; // Set input values
        #period;
        if (!(out === 31'b1100101100001001100001010110010)) begin
            $display("Mismatch at index 6: Inputs = ["31'b10110010110000101000010001100101"], Generated = ['out'], Reference = ["31'b1100101100001001100001010110010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 31'b10001001001101110101001000010010, Generated = out, Reference = 31'b0010010010100100011011110001001
        in = 31'b10001001001101110101001000010010; // Set input values
        #period;
        if (!(out === 31'b0010010010100100011011110001001)) begin
            $display("Mismatch at index 7: Inputs = ["31'b10001001001101110101001000010010"], Generated = ['out'], Reference = ["31'b0010010010100100011011110001001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 31'b0000000111100111110001100000001, Generated = out, Reference = 31'b0000001111000111111001100000000
        in = 31'b0000000111100111110001100000001; // Set input values
        #period;
        if (!(out === 31'b0000001111000111111001100000000)) begin
            $display("Mismatch at index 8: Inputs = ["31'b0000000111100111110001100000001"], Generated = ['out'], Reference = ["31'b0000001111000111111001100000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 9);
        $finish;
    end

endmodule