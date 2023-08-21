module top_module_tb;


    wire tff.clk;
    wire tff.reset;
    wire tff.t;
    wire tff.q;


    top_module UUT (.tff.clk(tff.clk), .tff.reset(tff.reset), .tff.t(tff.t), .tff.q(tff.q));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        ; // Set input values
        #period;
        if (!()) begin
            $display("Mismatch at index 0: Inputs = [], Generated = ['tff.clk', 'tff.reset', 'tff.t', 'tff.q'], Reference = []");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        ; // Set input values
        #period;
        if (!()) begin
            $display("Mismatch at index 1: Inputs = [], Generated = ['tff.clk', 'tff.reset', 'tff.t', 'tff.q'], Reference = []");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        ; // Set input values
        #period;
        if (!()) begin
            $display("Mismatch at index 2: Inputs = [], Generated = ['tff.clk', 'tff.reset', 'tff.t', 'tff.q'], Reference = []");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        ; // Set input values
        #period;
        if (!()) begin
            $display("Mismatch at index 3: Inputs = [], Generated = ['tff.clk', 'tff.reset', 'tff.t', 'tff.q'], Reference = []");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        ; // Set input values
        #period;
        if (!()) begin
            $display("Mismatch at index 4: Inputs = [], Generated = ['tff.clk', 'tff.reset', 'tff.t', 'tff.q'], Reference = []");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        ; // Set input values
        #period;
        if (!()) begin
            $display("Mismatch at index 5: Inputs = [], Generated = ['tff.clk', 'tff.reset', 'tff.t', 'tff.q'], Reference = []");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        ; // Set input values
        #period;
        if (!()) begin
            $display("Mismatch at index 6: Inputs = [], Generated = ['tff.clk', 'tff.reset', 'tff.t', 'tff.q'], Reference = []");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        ; // Set input values
        #period;
        if (!()) begin
            $display("Mismatch at index 7: Inputs = [], Generated = ['tff.clk', 'tff.reset', 'tff.t', 'tff.q'], Reference = []");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 8);
        $finish;
    end

endmodule