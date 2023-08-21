module top_module_tb;


    wire q7.clk;
    wire q7.in;
    wire q7.s;
    wire q7.out;


    top_module UUT (.q7.clk(q7.clk), .q7.in(q7.in), .q7.s(q7.s), .q7.out(q7.out));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0000, 4'b0000, 4'b0010, 8'bx
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0000 && q7.in === 4'b0000 && q7.s === 4'b0010 && q7.out === 8'bx)) begin
            $display("Mismatch at index 0: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0000", "4'b0000", "4'b0010", "8'bx"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0001, 4'b0000, 4'b0010, 8'bx
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0001 && q7.in === 4'b0000 && q7.s === 4'b0010 && q7.out === 8'bx)) begin
            $display("Mismatch at index 1: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0001", "4'b0000", "4'b0010", "8'bx"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0000, 4'b0000, 4'b0110, 8'bx
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0000 && q7.in === 4'b0000 && q7.s === 4'b0110 && q7.out === 8'bx)) begin
            $display("Mismatch at index 2: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0000", "4'b0000", "4'b0110", "8'bx"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0001, 4'b0000, 4'b0110, 4'b0000
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0001 && q7.in === 4'b0000 && q7.s === 4'b0110 && q7.out === 4'b0000)) begin
            $display("Mismatch at index 3: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0001", "4'b0000", "4'b0110", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0000, 4'b0001, 4'b0010, 4'b0000
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0000 && q7.in === 4'b0001 && q7.s === 4'b0010 && q7.out === 4'b0000)) begin
            $display("Mismatch at index 4: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0000", "4'b0001", "4'b0010", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0001, 4'b0001, 4'b0010, 4'b0000
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0001 && q7.in === 4'b0001 && q7.s === 4'b0010 && q7.out === 4'b0000)) begin
            $display("Mismatch at index 5: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0001", "4'b0001", "4'b0010", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0000, 4'b0000, 4'b0111, 4'b0000
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0000 && q7.in === 4'b0000 && q7.s === 4'b0111 && q7.out === 4'b0000)) begin
            $display("Mismatch at index 6: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0000", "4'b0000", "4'b0111", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0001, 4'b0000, 4'b0111, 4'b0001
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0001 && q7.in === 4'b0000 && q7.s === 4'b0111 && q7.out === 4'b0001)) begin
            $display("Mismatch at index 7: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0001", "4'b0000", "4'b0111", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0000, 4'b0001, 4'b0000, 4'b0001
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0000 && q7.in === 4'b0001 && q7.s === 4'b0000 && q7.out === 4'b0001)) begin
            $display("Mismatch at index 8: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0000", "4'b0001", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0001, 4'b0001, 4'b0000, 4'b0001
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0001 && q7.in === 4'b0001 && q7.s === 4'b0000 && q7.out === 4'b0001)) begin
            $display("Mismatch at index 9: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0001", "4'b0001", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0000, 4'b0001, 4'b0000, 4'b0001
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0000 && q7.in === 4'b0001 && q7.s === 4'b0000 && q7.out === 4'b0001)) begin
            $display("Mismatch at index 10: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0000", "4'b0001", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0001, 4'b0001, 4'b0000, 4'b0000
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0001 && q7.in === 4'b0001 && q7.s === 4'b0000 && q7.out === 4'b0000)) begin
            $display("Mismatch at index 11: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0001", "4'b0001", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0000, 4'b0001, 4'b0000, 4'b0000
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0000 && q7.in === 4'b0001 && q7.s === 4'b0000 && q7.out === 4'b0000)) begin
            $display("Mismatch at index 12: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0000", "4'b0001", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0001, 4'b0001, 4'b0000, 4'b0000
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0001 && q7.in === 4'b0001 && q7.s === 4'b0000 && q7.out === 4'b0000)) begin
            $display("Mismatch at index 13: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0001", "4'b0001", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0000 && q7.in === 4'b0000 && q7.s === 4'b0000 && q7.out === 4'b0000)) begin
            $display("Mismatch at index 14: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 4'b0001, 4'b0000, 4'b0000, 4'b0000
        ; // Set input values
        #period;
        if (!(q7.clk === 4'b0001 && q7.in === 4'b0000 && q7.s === 4'b0000 && q7.out === 4'b0000)) begin
            $display("Mismatch at index 15: Inputs = [], Generated = ['q7.clk', 'q7.in', 'q7.s', 'q7.out'], Reference = ["4'b0001", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 16);
        $finish;
    end

endmodule