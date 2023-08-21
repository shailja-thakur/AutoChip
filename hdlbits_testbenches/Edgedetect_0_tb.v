module top_module_tb;

    reg clk;
    reg [6:0] in;

    wire [6:0] pedge;


    top_module UUT (.clk(clk), .in(in), .pedge(pedge));

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

        // Tick 0: Inputs = High, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 0: Inputs = ['High' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = Low, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 1: Inputs = ['Low' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = High, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 2: Inputs = ['High' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = Low, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 3: Inputs = ['Low' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = High, 7'b0000001, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000001; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 4: Inputs = ['High' "7'b0000001"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = Low, 7'b0000001, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000001; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 5: Inputs = ['Low' "7'b0000001"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = High, 7'b0000001, Generated = pedge, Reference = 7'b0000001
        in = 7'b0000001; // Set input values
        #period;
        if (!(pedge === 7'b0000001)) begin
            $display("Mismatch at index 6: Inputs = ['High' "7'b0000001"], Generated = ['pedge'], Reference = ["7'b0000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = Low, 7'b0000001, Generated = pedge, Reference = 7'b0000001
        in = 7'b0000001; // Set input values
        #period;
        if (!(pedge === 7'b0000001)) begin
            $display("Mismatch at index 7: Inputs = ['Low' "7'b0000001"], Generated = ['pedge'], Reference = ["7'b0000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = High, 7'b0000001, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000001; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 8: Inputs = ['High' "7'b0000001"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = Low, 7'b0000001, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000001; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 9: Inputs = ['Low' "7'b0000001"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = High, 7'b0000001, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000001; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 10: Inputs = ['High' "7'b0000001"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = Low, 7'b0000001, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000001; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 11: Inputs = ['Low' "7'b0000001"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = High, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 12: Inputs = ['High' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = Low, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 13: Inputs = ['Low' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = High, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 14: Inputs = ['High' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = Low, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 15: Inputs = ['Low' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = High, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 16: Inputs = ['High' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = Low, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 17: Inputs = ['Low' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = High, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 18: Inputs = ['High' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = Low, 7'b0000110, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000110; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 19: Inputs = ['Low' "7'b0000110"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = High, 7'b0000110, Generated = pedge, Reference = 7'b0000110
        in = 7'b0000110; // Set input values
        #period;
        if (!(pedge === 7'b0000110)) begin
            $display("Mismatch at index 20: Inputs = ['High' "7'b0000110"], Generated = ['pedge'], Reference = ["7'b0000110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = Low, 7'b0000110, Generated = pedge, Reference = 7'b0000110
        in = 7'b0000110; // Set input values
        #period;
        if (!(pedge === 7'b0000110)) begin
            $display("Mismatch at index 21: Inputs = ['Low' "7'b0000110"], Generated = ['pedge'], Reference = ["7'b0000110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 21 passed!");
        end

        // Tick 22: Inputs = High, 7'b0000110, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000110; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 22: Inputs = ['High' "7'b0000110"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 22 passed!");
        end

        // Tick 23: Inputs = Low, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 23: Inputs = ['Low' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 23 passed!");
        end

        // Tick 24: Inputs = High, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 24: Inputs = ['High' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 24 passed!");
        end

        // Tick 25: Inputs = Low, 7'b0000000, Generated = pedge, Reference = 7'b0000000
        in = 7'b0000000; // Set input values
        #period;
        if (!(pedge === 7'b0000000)) begin
            $display("Mismatch at index 25: Inputs = ['Low' "7'b0000000"], Generated = ['pedge'], Reference = ["7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 25 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 26);
        $finish;
    end

endmodule