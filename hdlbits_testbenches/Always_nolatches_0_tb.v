module top_module_tb;

    reg [14:0] scancode;

    wire left;
    wire down;
    wire right;
    wire up;


    top_module UUT (.scancode(scancode), .left(left), .down(down), .right(right), .up(up));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = x, Generated = left, down, right, up, Reference = 8'bx, 8'bx, 8'bx, 8'bx
        scancode = 8'bx; // Set input values
        #period;
        if (!(left === 8'bx && down === 8'bx && right === 8'bx && up === 8'bx)) begin
            $display("Mismatch at index 0: Inputs = ['x'], Generated = ['left', 'down', 'right', 'up'], Reference = ["8'bx", "8'bx", "8'bx", "8'bx"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 15'b000000000000000, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b000000000000000; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 1: Inputs = ["15'b000000000000000"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 15'b000000000000000, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b000000000000000; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 2: Inputs = ["15'b000000000000000"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 15'b000000000000001, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b000000000000001; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 3: Inputs = ["15'b000000000000001"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 15'b000000000000001, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b000000000000001; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 4: Inputs = ["15'b000000000000001"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 15'b1110000001110101, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0001
        scancode = 15'b1110000001110101; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0001)) begin
            $display("Mismatch at index 5: Inputs = ["15'b1110000001110101"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 15'b1110000001110101, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0001
        scancode = 15'b1110000001110101; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0001)) begin
            $display("Mismatch at index 6: Inputs = ["15'b1110000001110101"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 15'b1110000001101011, Generated = left, down, right, up, Reference = 4'b0001, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b1110000001101011; // Set input values
        #period;
        if (!(left === 4'b0001 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 7: Inputs = ["15'b1110000001101011"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0001", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 15'b1110000001101011, Generated = left, down, right, up, Reference = 4'b0001, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b1110000001101011; // Set input values
        #period;
        if (!(left === 4'b0001 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 8: Inputs = ["15'b1110000001101011"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0001", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 15'b1110000001101100, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b1110000001101100; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 9: Inputs = ["15'b1110000001101100"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 15'b1110000001101100, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b1110000001101100; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 10: Inputs = ["15'b1110000001101100"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 15'b1110000001110010, Generated = left, down, right, up, Reference = 4'b0000, 4'b0001, 4'b0000, 4'b0000
        scancode = 15'b1110000001110010; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0001 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 11: Inputs = ["15'b1110000001110010"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0001", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 15'b1110000001110010, Generated = left, down, right, up, Reference = 4'b0000, 4'b0001, 4'b0000, 4'b0000
        scancode = 15'b1110000001110010; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0001 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 12: Inputs = ["15'b1110000001110010"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0001", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 15'b1110000001110100, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        scancode = 15'b1110000001110100; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0001 && up === 4'b0000)) begin
            $display("Mismatch at index 13: Inputs = ["15'b1110000001110100"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 15'b1110000001110100, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        scancode = 15'b1110000001110100; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0001 && up === 4'b0000)) begin
            $display("Mismatch at index 14: Inputs = ["15'b1110000001110100"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 15'b1110000001110110, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b1110000001110110; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 15: Inputs = ["15'b1110000001110110"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 15'b1110000001110110, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b1110000001110110; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 16: Inputs = ["15'b1110000001110110"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 15'b1111111111111111, Generated = left, down, right, up, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        scancode = 15'b1111111111111111; // Set input values
        #period;
        if (!(left === 4'b0000 && down === 4'b0000 && right === 4'b0000 && up === 4'b0000)) begin
            $display("Mismatch at index 17: Inputs = ["15'b1111111111111111"], Generated = ['left', 'down', 'right', 'up'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
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