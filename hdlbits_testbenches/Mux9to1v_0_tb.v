module top_module_tb;

    reg [14:0] a;
    reg b;
    reg c;
    reg d;
    reg e;
    reg f;
    reg g;
    reg h;
    reg i;
    reg [2:0] sel;

    wire [14:0] out;


    top_module UUT (.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h), .i(i), .sel(sel), .out(out));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b000, Generated = out, Reference = 15'b000000000001010
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b000; // Set input values
        #period;
        if (!(out === 15'b000000000001010)) begin
            $display("Mismatch at index 0: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b000"], Generated = ['out'], Reference = ["15'b000000000001010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b001, Generated = out, Reference = 15'b000000000001011
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b001; // Set input values
        #period;
        if (!(out === 15'b000000000001011)) begin
            $display("Mismatch at index 1: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b001"], Generated = ['out'], Reference = ["15'b000000000001011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b001, Generated = out, Reference = 15'b000000000001011
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b001; // Set input values
        #period;
        if (!(out === 15'b000000000001011)) begin
            $display("Mismatch at index 2: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b001"], Generated = ['out'], Reference = ["15'b000000000001011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b010, Generated = out, Reference = 15'b000000000001100
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b010; // Set input values
        #period;
        if (!(out === 15'b000000000001100)) begin
            $display("Mismatch at index 3: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b010"], Generated = ['out'], Reference = ["15'b000000000001100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b010, Generated = out, Reference = 15'b000000000001100
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b010; // Set input values
        #period;
        if (!(out === 15'b000000000001100)) begin
            $display("Mismatch at index 4: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b010"], Generated = ['out'], Reference = ["15'b000000000001100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b011, Generated = out, Reference = 15'b000000000001101
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b011; // Set input values
        #period;
        if (!(out === 15'b000000000001101)) begin
            $display("Mismatch at index 5: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b011"], Generated = ['out'], Reference = ["15'b000000000001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b011, Generated = out, Reference = 15'b000000000001101
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b011; // Set input values
        #period;
        if (!(out === 15'b000000000001101)) begin
            $display("Mismatch at index 6: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b011"], Generated = ['out'], Reference = ["15'b000000000001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b100, Generated = out, Reference = 15'b000000000001110
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b100; // Set input values
        #period;
        if (!(out === 15'b000000000001110)) begin
            $display("Mismatch at index 7: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b100"], Generated = ['out'], Reference = ["15'b000000000001110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b100, Generated = out, Reference = 15'b000000000001110
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b100; // Set input values
        #period;
        if (!(out === 15'b000000000001110)) begin
            $display("Mismatch at index 8: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b100"], Generated = ['out'], Reference = ["15'b000000000001110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b111, Generated = out, Reference = 15'b000000000010010
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b111; // Set input values
        #period;
        if (!(out === 15'b000000000010010)) begin
            $display("Mismatch at index 9: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b111"], Generated = ['out'], Reference = ["15'b000000000010010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b111, Generated = out, Reference = 15'b000000000010010
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b111; // Set input values
        #period;
        if (!(out === 15'b000000000010010)) begin
            $display("Mismatch at index 10: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b111"], Generated = ['out'], Reference = ["15'b000000000010010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b1000, Generated = out, Reference = 15'b000000000010011
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b1000; // Set input values
        #period;
        if (!(out === 15'b000000000010011)) begin
            $display("Mismatch at index 11: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b1000"], Generated = ['out'], Reference = ["15'b000000000010011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b1000, Generated = out, Reference = 15'b000000000010011
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b1000; // Set input values
        #period;
        if (!(out === 15'b000000000010011)) begin
            $display("Mismatch at index 12: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b1000"], Generated = ['out'], Reference = ["15'b000000000010011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b1001, Generated = out, Reference = 15'b1111111111111111
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b1001; // Set input values
        #period;
        if (!(out === 15'b1111111111111111)) begin
            $display("Mismatch at index 13: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b1001"], Generated = ['out'], Reference = ["15'b1111111111111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b1001, Generated = out, Reference = 15'b1111111111111111
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b1001; // Set input values
        #period;
        if (!(out === 15'b1111111111111111)) begin
            $display("Mismatch at index 14: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b1001"], Generated = ['out'], Reference = ["15'b1111111111111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b1010, Generated = out, Reference = 15'b1111111111111111
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b1010; // Set input values
        #period;
        if (!(out === 15'b1111111111111111)) begin
            $display("Mismatch at index 15: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b1010"], Generated = ['out'], Reference = ["15'b1111111111111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b1010, Generated = out, Reference = 15'b1111111111111111
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b1010; // Set input values
        #period;
        if (!(out === 15'b1111111111111111)) begin
            $display("Mismatch at index 16: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b1010"], Generated = ['out'], Reference = ["15'b1111111111111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 15'b000000000001010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111, 8'b00010001, 8'b00010010, 8'b00010011, 3'b1011, Generated = out, Reference = 15'b1111111111111111
        a = 15'b000000000001010; b = 4'b1011; c = 4'b1100; d = 4'b1101; e = 4'b1110; f = 4'b1111; g = 8'b00010001; h = 8'b00010010; i = 8'b00010011; sel = 3'b1011; // Set input values
        #period;
        if (!(out === 15'b1111111111111111)) begin
            $display("Mismatch at index 17: Inputs = ["15'b000000000001010" "4'b1011" "4'b1100" "4'b1101" "4'b1110" "4'b1111"
 "8'b00010001" "8'b00010010" "8'b00010011" "3'b1011"], Generated = ['out'], Reference = ["15'b1111111111111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
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