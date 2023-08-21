module top_module_tb;

    reg a;
    reg b;

    wire out;


    top_module UUT (.a(a), .b(b), .out(out));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 4'b0000, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 0: Inputs = ["4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 4'b0000, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 1: Inputs = ["4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 4'b0000, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 2: Inputs = ["4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 4'b0000, 4'b0001, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 3: Inputs = ["4'b0000" "4'b0001"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 4'b0000, 4'b0001, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 4: Inputs = ["4'b0000" "4'b0001"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0001; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 5: Inputs = ["4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0001; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 6: Inputs = ["4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 4'b0001, 4'b0001, Generated = out, Reference = 4'b0001
        a = 4'b0001; b = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 7: Inputs = ["4'b0001" "4'b0001"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 4'b0001, 4'b0001, Generated = out, Reference = 4'b0001
        a = 4'b0001; b = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 8: Inputs = ["4'b0001" "4'b0001"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 4'b0000, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 9: Inputs = ["4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 4'b0000, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 10: Inputs = ["4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 4'b0000, 4'b0001, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 11: Inputs = ["4'b0000" "4'b0001"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 4'b0000, 4'b0001, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 12: Inputs = ["4'b0000" "4'b0001"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0001; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 13: Inputs = ["4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0001; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 14: Inputs = ["4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 4'b0001, 4'b0001, Generated = out, Reference = 4'b0001
        a = 4'b0001; b = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 15: Inputs = ["4'b0001" "4'b0001"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 4'b0001, 4'b0001, Generated = out, Reference = 4'b0001
        a = 4'b0001; b = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 16: Inputs = ["4'b0001" "4'b0001"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 4'b0000, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 17: Inputs = ["4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 4'b0000, 4'b0000, Generated = out, Reference = 4'b0000
        a = 4'b0000; b = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 18: Inputs = ["4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
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