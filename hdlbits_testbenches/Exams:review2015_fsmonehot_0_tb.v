`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg d;
    reg done_counting;
    reg ack;
    reg [9:0] state;

    wire B3_next;
    wire S_next;
    wire S1_next;
    wire Count_next;
    wire Wait_next;
    wire done;
    wire counting;
    wire shift_ena;


    integer mismatch_count;

    top_module UUT (.d(d), .done_counting(done_counting), .ack(ack), .state(state), .B3_next(B3_next), .S_next(S_next), .S1_next(S1_next), .Count_next(Count_next), .Wait_next(Wait_next), .done(done), .counting(counting), .shift_ena(shift_ena));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b0, 1'b0, 1'b0, 10'b0010000000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1
        d = 1'b0; done_counting = 1'b0; ack = 1'b0; state = 10'b0010000000; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b1 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b1)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b0, 1'b0, 1'b0, 10'b0010000000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b0, 1'b0, 1'b1, 10'b0010000000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1
        d = 1'b0; done_counting = 1'b0; ack = 1'b1; state = 10'b0010000000; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b1 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b1)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b0, 1'b0, 1'b1, 10'b0010000000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b1, 1'b0, 1'b1, 10'b0010000000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1
        d = 1'b1; done_counting = 1'b0; ack = 1'b1; state = 10'b0010000000; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b1 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b1)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b1, 1'b0, 1'b1, 10'b0010000000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b1, 1'b0, 1'b1, 10'b0000000100, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0
        d = 1'b1; done_counting = 1'b0; ack = 1'b1; state = 10'b0000000100; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b0)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b1, 1'b0, 1'b1, 10'b0000000100, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b0, 1'b0, 1'b1, 10'b1000000000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0
        d = 1'b0; done_counting = 1'b0; ack = 1'b1; state = 10'b1000000000; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b1 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b0 && done === 1'b1 && counting === 1'b0 && shift_ena === 1'b0)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b0, 1'b0, 1'b1, 10'b1000000000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b1, 1'b1, 1'b0, 10'b0010000000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1
        d = 1'b1; done_counting = 1'b1; ack = 1'b0; state = 10'b0010000000; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b1 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b1)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b1, 1'b1, 1'b0, 10'b0010000000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b1, 1'b0, 1'b1, 10'b0000000100, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0
        d = 1'b1; done_counting = 1'b0; ack = 1'b1; state = 10'b0000000100; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b0)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b1, 1'b0, 1'b1, 10'b0000000100, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b0, 1'b0, 1'b1, 10'b0001000000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1
        d = 1'b0; done_counting = 1'b0; ack = 1'b1; state = 10'b0001000000; // Set input values
        #period;
        if (!(B3_next === 1'b1 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b1)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b0, 1'b0, 1'b1, 10'b0001000000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b1, 1'b0, 1'b1, 10'b0000000100, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0
        d = 1'b1; done_counting = 1'b0; ack = 1'b1; state = 10'b0000000100; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b0)) begin
            $display("Mismatch at index 8: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b1, 1'b0, 1'b1, 10'b0000000100, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b1, 1'b0, 1'b1, 10'b0000100000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1
        d = 1'b1; done_counting = 1'b0; ack = 1'b1; state = 10'b0000100000; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b1)) begin
            $display("Mismatch at index 9: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b1, 1'b0, 1'b1, 10'b0000100000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 1'b0, 1'b1, 1'b0, 10'b1000000000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0
        d = 1'b0; done_counting = 1'b1; ack = 1'b0; state = 10'b1000000000; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b1 && done === 1'b1 && counting === 1'b0 && shift_ena === 1'b0)) begin
            $display("Mismatch at index 10: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b0, 1'b1, 1'b0, 10'b1000000000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 1'b0, 1'b1, 1'b0, 10'b0000000001, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0
        d = 1'b0; done_counting = 1'b1; ack = 1'b0; state = 10'b0000000001; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b1 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b0)) begin
            $display("Mismatch at index 11: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b0, 1'b1, 1'b0, 10'b0000000001, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 1'b0, 1'b0, 1'b0, 10'b0000001000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0
        d = 1'b0; done_counting = 1'b0; ack = 1'b0; state = 10'b0000001000; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b1 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b0)) begin
            $display("Mismatch at index 12: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b0, 1'b0, 1'b0, 10'b0000001000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 1'b1, 1'b0, 1'b0, 10'b0000001000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0
        d = 1'b1; done_counting = 1'b0; ack = 1'b0; state = 10'b0000001000; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b0 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b0 && done === 1'b0 && counting === 1'b0 && shift_ena === 1'b0)) begin
            $display("Mismatch at index 13: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b1, 1'b0, 1'b0, 10'b0000001000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 1'b1, 1'b0, 1'b1, 10'b1000000000, Generated = B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, Reference = 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0
        d = 1'b1; done_counting = 1'b0; ack = 1'b1; state = 10'b1000000000; // Set input values
        #period;
        if (!(B3_next === 1'b0 && S_next === 1'b1 && S1_next === 1'b0 && Count_next === 1'b0 && Wait_next === 1'b0 && done === 1'b1 && counting === 1'b0 && shift_ena === 1'b0)) begin
            $display("Mismatch at index 14: Inputs = [%b, %b, %b, %b], Generated = [%b, %b, %b, %b, %b, %b, %b, %b], Reference = [%b, %b, %b, %b, %b, %b, %b, %b]", 1'b1, 1'b0, 1'b1, 10'b1000000000, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 14 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 15);
        $finish;
    end

endmodule