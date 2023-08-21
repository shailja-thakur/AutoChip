module top_module_tb;

    reg [6:0] code;

    wire [2:0] out;
    wire valid;


    top_module UUT (.code(code), .out(out), .valid(valid));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 7'b1000101, Generated = out, valid, Reference = 3'b000, 4'b0001
        code = 7'b1000101; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0001)) begin
            $display("Mismatch at index 0: Inputs = ["7'b1000101"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 7'b1000101, Generated = out, valid, Reference = 3'b000, 4'b0001
        code = 7'b1000101; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0001)) begin
            $display("Mismatch at index 1: Inputs = ["7'b1000101"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 7'b1000101, Generated = out, valid, Reference = 3'b000, 4'b0001
        code = 7'b1000101; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0001)) begin
            $display("Mismatch at index 2: Inputs = ["7'b1000101"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 7'b0000011, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0000011; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 3: Inputs = ["7'b0000011"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 7'b0000011, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0000011; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 4: Inputs = ["7'b0000011"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 7'b0000110, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0000110; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 5: Inputs = ["7'b0000110"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 7'b0000110, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0000110; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 6: Inputs = ["7'b0000110"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 7'b0010110, Generated = out, valid, Reference = 3'b001, 4'b0001
        code = 7'b0010110; // Set input values
        #period;
        if (!(out === 3'b001 && valid === 4'b0001)) begin
            $display("Mismatch at index 7: Inputs = ["7'b0010110"], Generated = ['out', 'valid'], Reference = ["3'b001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 7'b0010110, Generated = out, valid, Reference = 3'b001, 4'b0001
        code = 7'b0010110; // Set input values
        #period;
        if (!(out === 3'b001 && valid === 4'b0001)) begin
            $display("Mismatch at index 8: Inputs = ["7'b0010110"], Generated = ['out', 'valid'], Reference = ["3'b001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 7'b0011010, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0011010; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 9: Inputs = ["7'b0011010"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 7'b0011010, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0011010; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 10: Inputs = ["7'b0011010"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 7'b0011110, Generated = out, valid, Reference = 3'b010, 4'b0001
        code = 7'b0011110; // Set input values
        #period;
        if (!(out === 3'b010 && valid === 4'b0001)) begin
            $display("Mismatch at index 11: Inputs = ["7'b0011110"], Generated = ['out', 'valid'], Reference = ["3'b010", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 7'b0011110, Generated = out, valid, Reference = 3'b010, 4'b0001
        code = 7'b0011110; // Set input values
        #period;
        if (!(out === 3'b010 && valid === 4'b0001)) begin
            $display("Mismatch at index 12: Inputs = ["7'b0011110"], Generated = ['out', 'valid'], Reference = ["3'b010", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 7'b0100101, Generated = out, valid, Reference = 3'b100, 4'b0001
        code = 7'b0100101; // Set input values
        #period;
        if (!(out === 3'b100 && valid === 4'b0001)) begin
            $display("Mismatch at index 13: Inputs = ["7'b0100101"], Generated = ['out', 'valid'], Reference = ["3'b100", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 7'b0100101, Generated = out, valid, Reference = 3'b100, 4'b0001
        code = 7'b0100101; // Set input values
        #period;
        if (!(out === 3'b100 && valid === 4'b0001)) begin
            $display("Mismatch at index 14: Inputs = ["7'b0100101"], Generated = ['out', 'valid'], Reference = ["3'b100", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 7'b0100110, Generated = out, valid, Reference = 3'b011, 4'b0001
        code = 7'b0100110; // Set input values
        #period;
        if (!(out === 3'b011 && valid === 4'b0001)) begin
            $display("Mismatch at index 15: Inputs = ["7'b0100110"], Generated = ['out', 'valid'], Reference = ["3'b011", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 7'b0100110, Generated = out, valid, Reference = 3'b011, 4'b0001
        code = 7'b0100110; // Set input values
        #period;
        if (!(out === 3'b011 && valid === 4'b0001)) begin
            $display("Mismatch at index 16: Inputs = ["7'b0100110"], Generated = ['out', 'valid'], Reference = ["3'b011", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 7'b0101110, Generated = out, valid, Reference = 3'b101, 4'b0001
        code = 7'b0101110; // Set input values
        #period;
        if (!(out === 3'b101 && valid === 4'b0001)) begin
            $display("Mismatch at index 17: Inputs = ["7'b0101110"], Generated = ['out', 'valid'], Reference = ["3'b101", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 7'b0101110, Generated = out, valid, Reference = 3'b101, 4'b0001
        code = 7'b0101110; // Set input values
        #period;
        if (!(out === 3'b101 && valid === 4'b0001)) begin
            $display("Mismatch at index 18: Inputs = ["7'b0101110"], Generated = ['out', 'valid'], Reference = ["3'b101", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = 7'b0100100, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0100100; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 19: Inputs = ["7'b0100100"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = 7'b0100100, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0100100; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 20: Inputs = ["7'b0100100"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = 7'b0110110, Generated = out, valid, Reference = 3'b110, 4'b0001
        code = 7'b0110110; // Set input values
        #period;
        if (!(out === 3'b110 && valid === 4'b0001)) begin
            $display("Mismatch at index 21: Inputs = ["7'b0110110"], Generated = ['out', 'valid'], Reference = ["3'b110", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 21 passed!");
        end

        // Tick 22: Inputs = 7'b0110110, Generated = out, valid, Reference = 3'b110, 4'b0001
        code = 7'b0110110; // Set input values
        #period;
        if (!(out === 3'b110 && valid === 4'b0001)) begin
            $display("Mismatch at index 22: Inputs = ["7'b0110110"], Generated = ['out', 'valid'], Reference = ["3'b110", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 22 passed!");
        end

        // Tick 23: Inputs = 7'b10000001, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b10000001; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 23: Inputs = ["7'b10000001"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 23 passed!");
        end

        // Tick 24: Inputs = 7'b10000001, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b10000001; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 24: Inputs = ["7'b10000001"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 24 passed!");
        end

        // Tick 25: Inputs = 7'b0111101, Generated = out, valid, Reference = 3'b111, 4'b0001
        code = 7'b0111101; // Set input values
        #period;
        if (!(out === 3'b111 && valid === 4'b0001)) begin
            $display("Mismatch at index 25: Inputs = ["7'b0111101"], Generated = ['out', 'valid'], Reference = ["3'b111", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 25 passed!");
        end

        // Tick 26: Inputs = 7'b0111101, Generated = out, valid, Reference = 3'b111, 4'b0001
        code = 7'b0111101; // Set input values
        #period;
        if (!(out === 3'b111 && valid === 4'b0001)) begin
            $display("Mismatch at index 26: Inputs = ["7'b0111101"], Generated = ['out', 'valid'], Reference = ["3'b111", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 26 passed!");
        end

        // Tick 27: Inputs = 7'b0111110, Generated = out, valid, Reference = 3'b1000, 4'b0001
        code = 7'b0111110; // Set input values
        #period;
        if (!(out === 3'b1000 && valid === 4'b0001)) begin
            $display("Mismatch at index 27: Inputs = ["7'b0111110"], Generated = ['out', 'valid'], Reference = ["3'b1000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 27 passed!");
        end

        // Tick 28: Inputs = 7'b0111110, Generated = out, valid, Reference = 3'b1000, 4'b0001
        code = 7'b0111110; // Set input values
        #period;
        if (!(out === 3'b1000 && valid === 4'b0001)) begin
            $display("Mismatch at index 28: Inputs = ["7'b0111110"], Generated = ['out', 'valid'], Reference = ["3'b1000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 28 passed!");
        end

        // Tick 29: Inputs = 7'b1000101, Generated = out, valid, Reference = 3'b000, 4'b0001
        code = 7'b1000101; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0001)) begin
            $display("Mismatch at index 29: Inputs = ["7'b1000101"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 29 passed!");
        end

        // Tick 30: Inputs = 7'b1000101, Generated = out, valid, Reference = 3'b000, 4'b0001
        code = 7'b1000101; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0001)) begin
            $display("Mismatch at index 30: Inputs = ["7'b1000101"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 30 passed!");
        end

        // Tick 31: Inputs = 7'b1000110, Generated = out, valid, Reference = 3'b1001, 4'b0001
        code = 7'b1000110; // Set input values
        #period;
        if (!(out === 3'b1001 && valid === 4'b0001)) begin
            $display("Mismatch at index 31: Inputs = ["7'b1000110"], Generated = ['out', 'valid'], Reference = ["3'b1001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 31 passed!");
        end

        // Tick 32: Inputs = 7'b1000110, Generated = out, valid, Reference = 3'b1001, 4'b0001
        code = 7'b1000110; // Set input values
        #period;
        if (!(out === 3'b1001 && valid === 4'b0001)) begin
            $display("Mismatch at index 32: Inputs = ["7'b1000110"], Generated = ['out', 'valid'], Reference = ["3'b1001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 32 passed!");
        end

        // Tick 33: Inputs = 7'b0001001, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0001001; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 33: Inputs = ["7'b0001001"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 33 passed!");
        end

        // Tick 34: Inputs = 7'b0001001, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0001001; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 34: Inputs = ["7'b0001001"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 34 passed!");
        end

        // Tick 35: Inputs = 7'b1100011, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b1100011; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 35: Inputs = ["7'b1100011"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 35 passed!");
        end

        // Tick 36: Inputs = 7'b1100011, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b1100011; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 36: Inputs = ["7'b1100011"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 36 passed!");
        end

        // Tick 37: Inputs = 7'b0001101, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0001101; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 37: Inputs = ["7'b0001101"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 37 passed!");
        end

        // Tick 38: Inputs = 7'b0001101, Generated = out, valid, Reference = 3'b000, 4'b0000
        code = 7'b0001101; // Set input values
        #period;
        if (!(out === 3'b000 && valid === 4'b0000)) begin
            $display("Mismatch at index 38: Inputs = ["7'b0001101"], Generated = ['out', 'valid'], Reference = ["3'b000", "4'b0000"]");
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