`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;


    wire tff.clk;
    wire tff.reset;
    wire tff.t;
    wire tff.q;


    integer mismatch_count;

    top_module UUT (.tff.clk(tff.clk), .tff.reset(tff.reset), .tff.t(tff.t), .tff.q(tff.q));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        if (!()) begin
            $display("Mismatch at index 0: Inputs = [], Generated = [%b, %b, %b, %b], Reference = []", tff.clk, tff.reset, tff.t, tff.q);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        if (!()) begin
            $display("Mismatch at index 1: Inputs = [], Generated = [%b, %b, %b, %b], Reference = []", tff.clk, tff.reset, tff.t, tff.q);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        if (!()) begin
            $display("Mismatch at index 2: Inputs = [], Generated = [%b, %b, %b, %b], Reference = []", tff.clk, tff.reset, tff.t, tff.q);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        if (!()) begin
            $display("Mismatch at index 3: Inputs = [], Generated = [%b, %b, %b, %b], Reference = []", tff.clk, tff.reset, tff.t, tff.q);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        if (!()) begin
            $display("Mismatch at index 4: Inputs = [], Generated = [%b, %b, %b, %b], Reference = []", tff.clk, tff.reset, tff.t, tff.q);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        if (!()) begin
            $display("Mismatch at index 5: Inputs = [], Generated = [%b, %b, %b, %b], Reference = []", tff.clk, tff.reset, tff.t, tff.q);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        if (!()) begin
            $display("Mismatch at index 6: Inputs = [], Generated = [%b, %b, %b, %b], Reference = []", tff.clk, tff.reset, tff.t, tff.q);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        if (!()) begin
            $display("Mismatch at index 7: Inputs = [], Generated = [%b, %b, %b, %b], Reference = []", tff.clk, tff.reset, tff.t, tff.q);
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