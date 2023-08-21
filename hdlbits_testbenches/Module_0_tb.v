`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg a;
    reg b;
    reg c;
    reg d;

    wire out1;
    wire out2;


    top_module UUT (.a(a), .b(b), .c(c), .d(d), .out1(out1), .out2(out2));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 0: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 1: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 2: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 4'b0001, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0001, 4'b0001
        a = 4'b0001; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0001 && out2 === 4'b0001)) begin
            $display("Mismatch at index 3: Inputs = ["4'b0001" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 4: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 4'b0001, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0001, 4'b0001
        a = 4'b0001; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0001 && out2 === 4'b0001)) begin
            $display("Mismatch at index 5: Inputs = ["4'b0001" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 6: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 7: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 8: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 9: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0001, 4'b0001
        a = 4'b0000; b = 4'b0000; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0001 && out2 === 4'b0001)) begin
            $display("Mismatch at index 10: Inputs = ["4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 11: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0001, 4'b0001
        a = 4'b0000; b = 4'b0000; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0001 && out2 === 4'b0001)) begin
            $display("Mismatch at index 12: Inputs = ["4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 13: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 14: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 15: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 16: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 4'b0000, 4'b0001, 4'b0001, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0001; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 17: Inputs = ["4'b0000" "4'b0001" "4'b0001" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0000)) begin
            $display("Mismatch at index 18: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = 4'b0000, 4'b0001, 4'b0001, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0001; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 19: Inputs = ["4'b0000" "4'b0001" "4'b0001" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0000)) begin
            $display("Mismatch at index 20: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0000)) begin
            $display("Mismatch at index 21: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 21 passed!");
        end

        // Tick 22: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0000)) begin
            $display("Mismatch at index 22: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 22 passed!");
        end

        // Tick 23: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0000)) begin
            $display("Mismatch at index 23: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 23 passed!");
        end

        // Tick 24: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 24: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 24 passed!");
        end

        // Tick 25: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0000)) begin
            $display("Mismatch at index 25: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 25 passed!");
        end

        // Tick 26: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0000, Generated = out1, out2, Reference = 4'b0000, 4'b0001
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0000; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0001)) begin
            $display("Mismatch at index 26: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0000"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 26 passed!");
        end

        // Tick 27: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0000)) begin
            $display("Mismatch at index 27: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 27 passed!");
        end

        // Tick 28: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0000)) begin
            $display("Mismatch at index 28: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 28 passed!");
        end

        // Tick 29: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0000)) begin
            $display("Mismatch at index 29: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 29 passed!");
        end

        // Tick 30: Inputs = 4'b0000, 4'b0001, 4'b0000, 4'b0001, Generated = out1, out2, Reference = 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; c = 4'b0000; d = 4'b0001; // Set input values
        #period;
        if (!(out1 === 4'b0000 && out2 === 4'b0000)) begin
            $display("Mismatch at index 30: Inputs = ["4'b0000" "4'b0001" "4'b0000" "4'b0001"], Generated = ['out1', 'out2'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 30 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 31);
        $finish;
    end

endmodule