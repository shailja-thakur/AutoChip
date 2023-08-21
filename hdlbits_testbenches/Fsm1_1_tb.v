`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg clk;
    reg in;
    reg reset;

    wire out;


    top_module UUT (.clk(clk), .in(in), .reset(reset), .out(out));

    initial // clk generation
    begin
        clk = 0;
        forever begin
            #(period/2);
            clk = ~clk;
        end
    end

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = High, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 0: Inputs = ['High' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = Low, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 1: Inputs = ['Low' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = High, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 2: Inputs = ['High' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = Low, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 3: Inputs = ['Low' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = High, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 4: Inputs = ['High' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = Low, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 5: Inputs = ['Low' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = High, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 6: Inputs = ['High' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = Low, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 7: Inputs = ['Low' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = High, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 8: Inputs = ['High' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = Low, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 9: Inputs = ['Low' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = High, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 10: Inputs = ['High' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = Low, 4'b0001, 4'b0001, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 11: Inputs = ['Low' "4'b0001" "4'b0001"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = High, 4'b0001, 4'b0001, Generated = out, Reference = 4'b0001
        in = 4'b0001; reset = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 12: Inputs = ['High' "4'b0001" "4'b0001"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = Low, 4'b0001, 4'b0001, Generated = out, Reference = 4'b0001
        in = 4'b0001; reset = 4'b0001; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 13: Inputs = ['Low' "4'b0001" "4'b0001"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = High, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0001
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 14: Inputs = ['High' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = Low, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0001
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 15: Inputs = ['Low' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = High, 4'b0000, 4'b0000, Generated = out, Reference = 4'b0001
        in = 4'b0000; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 16: Inputs = ['High' "4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = Low, 4'b0000, 4'b0000, Generated = out, Reference = 4'b0001
        in = 4'b0000; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 17: Inputs = ['Low' "4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = High, 4'b0000, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0000; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 18: Inputs = ['High' "4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = Low, 4'b0000, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0000; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 19: Inputs = ['Low' "4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = High, 4'b0000, 4'b0000, Generated = out, Reference = 4'b0001
        in = 4'b0000; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 20: Inputs = ['High' "4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = Low, 4'b0000, 4'b0000, Generated = out, Reference = 4'b0001
        in = 4'b0000; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0001)) begin
            $display("Mismatch at index 21: Inputs = ['Low' "4'b0000" "4'b0000"], Generated = ['out'], Reference = ["4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 21 passed!");
        end

        // Tick 22: Inputs = High, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 22: Inputs = ['High' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 22 passed!");
        end

        // Tick 23: Inputs = Low, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 23: Inputs = ['Low' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 23 passed!");
        end

        // Tick 24: Inputs = High, 4'b0001, 4'b0000, Generated = out, Reference = 4'b0000
        in = 4'b0001; reset = 4'b0000; // Set input values
        #period;
        if (!(out === 4'b0000)) begin
            $display("Mismatch at index 24: Inputs = ['High' "4'b0001" "4'b0000"], Generated = ['out'], Reference = ["4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 24 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 25);
        $finish;
    end

endmodule