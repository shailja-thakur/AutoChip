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
        // Tick 1: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        // Tick 2: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        // Tick 3: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        // Tick 4: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        // Tick 5: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        // Tick 6: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        // Tick 7: Inputs = , Generated = tff.clk, tff.reset, tff.t, tff.q, Reference = 
        // No input assignments for this tick
        #period;
        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 8);
        $finish;
    end

endmodule