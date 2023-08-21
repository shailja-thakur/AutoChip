module top_module_tb;

    reg [3:0] a;
    reg b;
    reg c;
    reg d;
    reg e;
    reg f;

    wire [6:0] w;
    wire x;
    wire y;
    wire z;


    top_module UUT (.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .w(w), .x(x), .y(y), .z(z));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = x, x, x, x, x, x, Generated = w, x, y, z, Reference = 8'bx, 8'bx, 8'bx, 8'bx
        a = 8'bx; b = 8'bx; c = 8'bx; d = 8'bx; e = 8'bx; f = 8'bx; // Set input values
        #period;
        if (!(w === 8'bx && x === 8'bx && y === 8'bx && z === 8'bx)) begin
            $display("Mismatch at index 0: Inputs = ['x' 'x' 'x' 'x' 'x' 'x'], Generated = ['w', 'x', 'y', 'z'], Reference = ["8'bx", "8'bx", "8'bx", "8'bx"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b00000011)) begin
            $display("Mismatch at index 1: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b00000011)) begin
            $display("Mismatch at index 2: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00000001, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b00000111
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00000001; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b00000111)) begin
            $display("Mismatch at index 3: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00000001"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b00000111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00000001, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b00000111
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00000001; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b00000111)) begin
            $display("Mismatch at index 4: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00000001"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b00000111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00000010, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b00001011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00000010; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b00001011)) begin
            $display("Mismatch at index 5: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00000010"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b00001011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00000010, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b00001011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00000010; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b00001011)) begin
            $display("Mismatch at index 6: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00000010"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b00001011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00000100, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b00010011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00000100; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b00010011)) begin
            $display("Mismatch at index 7: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00000100"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b00010011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00000100, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b00010011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00000100; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b00010011)) begin
            $display("Mismatch at index 8: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00000100"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b00010011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00001000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b00100011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00001000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b00100011)) begin
            $display("Mismatch at index 9: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00001000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b00100011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00001000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b00100011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00001000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b00100011)) begin
            $display("Mismatch at index 10: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00001000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b00100011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00010000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b01000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00010000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b01000011)) begin
            $display("Mismatch at index 11: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00010000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b01000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000000, 8'b00010000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b01000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000000; f = 8'b00010000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b01000011)) begin
            $display("Mismatch at index 12: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000000" "8'b00010000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b01000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000001, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b10000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000001; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b10000011)) begin
            $display("Mismatch at index 13: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000001" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b10000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000001, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000000, 8'b10000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000001; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000000 && z === 8'b10000011)) begin
            $display("Mismatch at index 14: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000001" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000000", "8'b10000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000010, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000001, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000010; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000001 && z === 8'b00000011)) begin
            $display("Mismatch at index 15: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000010" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000001", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000010, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000001, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000010; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000001 && z === 8'b00000011)) begin
            $display("Mismatch at index 16: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000010" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000001", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000100, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000010, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000100; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000010 && z === 8'b00000011)) begin
            $display("Mismatch at index 17: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000100" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000010", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00000100, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000010, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00000100; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000010 && z === 8'b00000011)) begin
            $display("Mismatch at index 18: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00000100" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000010", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00001000, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000100, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00001000; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000100 && z === 8'b00000011)) begin
            $display("Mismatch at index 19: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00001000" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000100", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00001000, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00000100, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00001000; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00000100 && z === 8'b00000011)) begin
            $display("Mismatch at index 20: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00001000" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00000100", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00010000, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00001000, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00010000; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00001000 && z === 8'b00000011)) begin
            $display("Mismatch at index 21: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00010000" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00001000", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 21 passed!");
        end

        // Tick 22: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0000, 8'b00010000, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00001000, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0000; e = 8'b00010000; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00001000 && z === 8'b00000011)) begin
            $display("Mismatch at index 22: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0000" "8'b00010000" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00001000", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 22 passed!");
        end

        // Tick 23: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0001, 8'b00000000, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00010000, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0001; e = 8'b00000000; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00010000 && z === 8'b00000011)) begin
            $display("Mismatch at index 23: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0001" "8'b00000000" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00010000", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 23 passed!");
        end

        // Tick 24: Inputs = 4'b0000, 4'b0000, 8'b00000000, 4'b0001, 8'b00000000, 8'b00000000, Generated = w, x, y, z, Reference = 7'b0000000, 8'b00000000, 8'b00010000, 8'b00000011
        a = 4'b0000; b = 4'b0000; c = 8'b00000000; d = 4'b0001; e = 8'b00000000; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b0000000 && x === 8'b00000000 && y === 8'b00010000 && z === 8'b00000011)) begin
            $display("Mismatch at index 24: Inputs = ["4'b0000" "4'b0000" "8'b00000000" "4'b0001" "8'b00000000" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b0000000", "8'b00000000", "8'b00010000", "8'b00000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 24 passed!");
        end

        // Tick 25: Inputs = 4'b11111, 4'b0000, 8'b00011111, 4'b0000, 8'b00011111, 8'b00000000, Generated = w, x, y, z, Reference = 7'b11111000, 8'b00111110, 8'b00001111, 8'b10000011
        a = 4'b11111; b = 4'b0000; c = 8'b00011111; d = 4'b0000; e = 8'b00011111; f = 8'b00000000; // Set input values
        #period;
        if (!(w === 7'b11111000 && x === 8'b00111110 && y === 8'b00001111 && z === 8'b10000011)) begin
            $display("Mismatch at index 25: Inputs = ["4'b11111" "4'b0000" "8'b00011111" "4'b0000" "8'b00011111" "8'b00000000"], Generated = ['w', 'x', 'y', 'z'], Reference = ["7'b11111000", "8'b00111110", "8'b00001111", "8'b10000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 25 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 26);
        $finish;
    end

endmodule