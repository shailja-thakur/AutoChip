module top_module_tb;

    reg [0:0] sel;
    reg [6:0] a;
    reg [6:0] b;
    reg [6:0] c;
    reg [6:0] d;

    wire [6:0] out;


    top_module UUT (.sel(sel), .a(a), .b(b), .c(c), .d(d), .out(out));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b0, 7'b10101010, 7'b10111011, 7'b11001100, 7'b11011101, Generated = out, Reference = 7'b10101010
        sel = 1'b0; a = 7'b10101010; b = 7'b10111011; c = 7'b11001100; d = 7'b11011101; // Set input values
        #period;
        if (!(out === 7'b10101010)) begin
            $display("Mismatch at index 0: Inputs = ["1'b0" "7'b10101010" "7'b10111011" "7'b11001100" "7'b11011101"], Generated = ['out'], Reference = ["7'b10101010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b0, 7'b10101010, 7'b10111011, 7'b11001100, 7'b11011101, Generated = out, Reference = 7'b10101010
        sel = 1'b0; a = 7'b10101010; b = 7'b10111011; c = 7'b11001100; d = 7'b11011101; // Set input values
        #period;
        if (!(out === 7'b10101010)) begin
            $display("Mismatch at index 1: Inputs = ["1'b0" "7'b10101010" "7'b10111011" "7'b11001100" "7'b11011101"], Generated = ['out'], Reference = ["7'b10101010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b0, 7'b10101010, 7'b10111011, 7'b11001100, 7'b11011101, Generated = out, Reference = 7'b10101010
        sel = 1'b0; a = 7'b10101010; b = 7'b10111011; c = 7'b11001100; d = 7'b11011101; // Set input values
        #period;
        if (!(out === 7'b10101010)) begin
            $display("Mismatch at index 2: Inputs = ["1'b0" "7'b10101010" "7'b10111011" "7'b11001100" "7'b11011101"], Generated = ['out'], Reference = ["7'b10101010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b0, 7'b10101010, 7'b10111011, 7'b11001100, 7'b11011101, Generated = out, Reference = 7'b10101010
        sel = 1'b0; a = 7'b10101010; b = 7'b10111011; c = 7'b11001100; d = 7'b11011101; // Set input values
        #period;
        if (!(out === 7'b10101010)) begin
            $display("Mismatch at index 3: Inputs = ["1'b0" "7'b10101010" "7'b10111011" "7'b11001100" "7'b11011101"], Generated = ['out'], Reference = ["7'b10101010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b1, 7'b10101010, 7'b10111011, 7'b11001100, 7'b11011101, Generated = out, Reference = 7'b10111011
        sel = 1'b1; a = 7'b10101010; b = 7'b10111011; c = 7'b11001100; d = 7'b11011101; // Set input values
        #period;
        if (!(out === 7'b10111011)) begin
            $display("Mismatch at index 4: Inputs = ["1'b1" "7'b10101010" "7'b10111011" "7'b11001100" "7'b11011101"], Generated = ['out'], Reference = ["7'b10111011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b10, 7'b10101010, 7'b10111011, 7'b11001100, 7'b11011101, Generated = out, Reference = 7'b11001100
        sel = 1'b10; a = 7'b10101010; b = 7'b10111011; c = 7'b11001100; d = 7'b11011101; // Set input values
        #period;
        if (!(out === 7'b11001100)) begin
            $display("Mismatch at index 5: Inputs = ["1'b10" "7'b10101010" "7'b10111011" "7'b11001100" "7'b11011101"], Generated = ['out'], Reference = ["7'b11001100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b11, 7'b10101010, 7'b10111011, 7'b11001100, 7'b11011101, Generated = out, Reference = 7'b11011101
        sel = 1'b11; a = 7'b10101010; b = 7'b10111011; c = 7'b11001100; d = 7'b11011101; // Set input values
        #period;
        if (!(out === 7'b11011101)) begin
            $display("Mismatch at index 6: Inputs = ["1'b11" "7'b10101010" "7'b10111011" "7'b11001100" "7'b11011101"], Generated = ['out'], Reference = ["7'b11011101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b0, 7'b1111111, 7'b0000000, 7'b1010101, 7'b0101010, Generated = out, Reference = 7'b1111111
        sel = 1'b0; a = 7'b1111111; b = 7'b0000000; c = 7'b1010101; d = 7'b0101010; // Set input values
        #period;
        if (!(out === 7'b1111111)) begin
            $display("Mismatch at index 7: Inputs = ["1'b0" "7'b1111111" "7'b0000000" "7'b1010101" "7'b0101010"], Generated = ['out'], Reference = ["7'b1111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b0, 7'b1111111, 7'b0000000, 7'b1010101, 7'b0101010, Generated = out, Reference = 7'b1111111
        sel = 1'b0; a = 7'b1111111; b = 7'b0000000; c = 7'b1010101; d = 7'b0101010; // Set input values
        #period;
        if (!(out === 7'b1111111)) begin
            $display("Mismatch at index 8: Inputs = ["1'b0" "7'b1111111" "7'b0000000" "7'b1010101" "7'b0101010"], Generated = ['out'], Reference = ["7'b1111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b0, 7'b1111111, 7'b0000000, 7'b1010101, 7'b0101010, Generated = out, Reference = 7'b1111111
        sel = 1'b0; a = 7'b1111111; b = 7'b0000000; c = 7'b1010101; d = 7'b0101010; // Set input values
        #period;
        if (!(out === 7'b1111111)) begin
            $display("Mismatch at index 9: Inputs = ["1'b0" "7'b1111111" "7'b0000000" "7'b1010101" "7'b0101010"], Generated = ['out'], Reference = ["7'b1111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 1'b0, 7'b1111111, 7'b0000000, 7'b1010101, 7'b0101010, Generated = out, Reference = 7'b1111111
        sel = 1'b0; a = 7'b1111111; b = 7'b0000000; c = 7'b1010101; d = 7'b0101010; // Set input values
        #period;
        if (!(out === 7'b1111111)) begin
            $display("Mismatch at index 10: Inputs = ["1'b0" "7'b1111111" "7'b0000000" "7'b1010101" "7'b0101010"], Generated = ['out'], Reference = ["7'b1111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 1'b1, 7'b1111111, 7'b0000000, 7'b1010101, 7'b0101010, Generated = out, Reference = 7'b0000000
        sel = 1'b1; a = 7'b1111111; b = 7'b0000000; c = 7'b1010101; d = 7'b0101010; // Set input values
        #period;
        if (!(out === 7'b0000000)) begin
            $display("Mismatch at index 11: Inputs = ["1'b1" "7'b1111111" "7'b0000000" "7'b1010101" "7'b0101010"], Generated = ['out'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 1'b10, 7'b1111111, 7'b0000000, 7'b1010101, 7'b0101010, Generated = out, Reference = 7'b1010101
        sel = 1'b10; a = 7'b1111111; b = 7'b0000000; c = 7'b1010101; d = 7'b0101010; // Set input values
        #period;
        if (!(out === 7'b1010101)) begin
            $display("Mismatch at index 12: Inputs = ["1'b10" "7'b1111111" "7'b0000000" "7'b1010101" "7'b0101010"], Generated = ['out'], Reference = ["7'b1010101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 1'b11, 7'b1111111, 7'b0000000, 7'b1010101, 7'b0101010, Generated = out, Reference = 7'b0101010
        sel = 1'b11; a = 7'b1111111; b = 7'b0000000; c = 7'b1010101; d = 7'b0101010; // Set input values
        #period;
        if (!(out === 7'b0101010)) begin
            $display("Mismatch at index 13: Inputs = ["1'b11" "7'b1111111" "7'b0000000" "7'b1010101" "7'b0101010"], Generated = ['out'], Reference = ["7'b0101010"]");
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