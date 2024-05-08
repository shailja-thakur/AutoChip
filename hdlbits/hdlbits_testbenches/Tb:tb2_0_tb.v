`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;


    wire q7.clk;
    wire q7.in;
    wire q7.s;
    wire q7.out;


    integer mismatch_count;

    top_module UUT (.q7.clk(q7.clk), .q7.in(q7.in), .q7.s(q7.s), .q7.out(q7.out));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b0, 1'b0, 1'b10, 1'bx
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b0 && q7.in === 1'b0 && q7.s === 1'b10)) begin
            $display("Mismatch at index 0: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b0, 1'b0, 1'b10, 1'bx);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b1, 1'b0, 1'b10, 1'bx
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b1 && q7.in === 1'b0 && q7.s === 1'b10)) begin
            $display("Mismatch at index 1: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b1, 1'b0, 1'b10, 1'bx);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b0, 1'b0, 1'b110, 1'bx
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b0 && q7.in === 1'b0 && q7.s === 1'b110)) begin
            $display("Mismatch at index 2: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b0, 1'b0, 1'b110, 1'bx);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b1, 1'b0, 1'b110, 1'b0
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b1 && q7.in === 1'b0 && q7.s === 1'b110 && q7.out === 1'b0)) begin
            $display("Mismatch at index 3: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b1, 1'b0, 1'b110, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b0, 1'b1, 1'b10, 1'b0
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b0 && q7.in === 1'b1 && q7.s === 1'b10 && q7.out === 1'b0)) begin
            $display("Mismatch at index 4: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b0, 1'b1, 1'b10, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b1, 1'b1, 1'b10, 1'b0
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b1 && q7.in === 1'b1 && q7.s === 1'b10 && q7.out === 1'b0)) begin
            $display("Mismatch at index 5: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b1, 1'b1, 1'b10, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b0, 1'b0, 1'b111, 1'b0
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b0 && q7.in === 1'b0 && q7.s === 1'b111 && q7.out === 1'b0)) begin
            $display("Mismatch at index 6: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b0, 1'b0, 1'b111, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b1, 1'b0, 1'b111, 1'b1
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b1 && q7.in === 1'b0 && q7.s === 1'b111 && q7.out === 1'b1)) begin
            $display("Mismatch at index 7: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b1, 1'b0, 1'b111, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b0, 1'b1, 1'b0, 1'b1
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b0 && q7.in === 1'b1 && q7.s === 1'b0 && q7.out === 1'b1)) begin
            $display("Mismatch at index 8: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b0, 1'b1, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b1, 1'b1, 1'b0, 1'b1
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b1 && q7.in === 1'b1 && q7.s === 1'b0 && q7.out === 1'b1)) begin
            $display("Mismatch at index 9: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b1, 1'b1, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b0, 1'b1, 1'b0, 1'b1
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b0 && q7.in === 1'b1 && q7.s === 1'b0 && q7.out === 1'b1)) begin
            $display("Mismatch at index 10: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b0, 1'b1, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b1, 1'b1, 1'b0, 1'b0
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b1 && q7.in === 1'b1 && q7.s === 1'b0 && q7.out === 1'b0)) begin
            $display("Mismatch at index 11: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b1, 1'b1, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b0, 1'b1, 1'b0, 1'b0
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b0 && q7.in === 1'b1 && q7.s === 1'b0 && q7.out === 1'b0)) begin
            $display("Mismatch at index 12: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b0, 1'b1, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b1, 1'b1, 1'b0, 1'b0
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b1 && q7.in === 1'b1 && q7.s === 1'b0 && q7.out === 1'b0)) begin
            $display("Mismatch at index 13: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b1, 1'b1, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b0, 1'b0, 1'b0, 1'b0
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b0 && q7.in === 1'b0 && q7.s === 1'b0 && q7.out === 1'b0)) begin
            $display("Mismatch at index 14: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b0, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = , Generated = q7.clk, q7.in, q7.s, q7.out, Reference = 1'b1, 1'b0, 1'b0, 1'b0
        // No input assignments for this tick
        #period;
        if (!(q7.clk === 1'b1 && q7.in === 1'b0 && q7.s === 1'b0 && q7.out === 1'b0)) begin
            $display("Mismatch at index 15: Inputs = [], Generated = [%b, %b, %b, %b], Reference = [%b, %b, %b, %b]", q7.clk, q7.in, q7.s, q7.out, 1'b1, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
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