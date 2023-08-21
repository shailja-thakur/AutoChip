`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;


    wire one;


    top_module UUT (.one(one));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 0: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 1: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 2: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 3: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 4: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 5: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 6: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 7: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 8: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 9: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 10: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 11: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 12: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 13: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 14: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 15: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 16: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 17: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = , Generated = one, Reference = 4'b0001
        ; // Set input values
        #period;
        if (!(one === 4'b0001)) begin
            $display("Mismatch at index 18: Inputs = [], Generated = ['one'], Reference = ["4'b0001"]");
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