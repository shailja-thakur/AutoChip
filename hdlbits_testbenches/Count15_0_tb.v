module top_module_tb;

    reg clk;
    reg reset;

    wire [2:0] q;


    top_module UUT (.clk(clk), .reset(reset), .q(q));

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

        // Tick 0: Inputs = Low, 4'b0001, Generated = q, Reference = 8'bx
        reset = 4'b0001; // Set input values
        #period;
        if (!(q === 8'bx)) begin
            $display("Mismatch at index 0: Inputs = ['Low' "4'b0001"], Generated = ['q'], Reference = ["8'bx"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = High, 4'b0001, Generated = q, Reference = 3'b000
        reset = 4'b0001; // Set input values
        #period;
        if (!(q === 3'b000)) begin
            $display("Mismatch at index 1: Inputs = ['High' "4'b0001"], Generated = ['q'], Reference = ["3'b000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = Low, 4'b0001, Generated = q, Reference = 3'b000
        reset = 4'b0001; // Set input values
        #period;
        if (!(q === 3'b000)) begin
            $display("Mismatch at index 2: Inputs = ['Low' "4'b0001"], Generated = ['q'], Reference = ["3'b000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = High, 4'b0000, Generated = q, Reference = 3'b000
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b000)) begin
            $display("Mismatch at index 3: Inputs = ['High' "4'b0000"], Generated = ['q'], Reference = ["3'b000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = Low, 4'b0000, Generated = q, Reference = 3'b000
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b000)) begin
            $display("Mismatch at index 4: Inputs = ['Low' "4'b0000"], Generated = ['q'], Reference = ["3'b000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = High, 4'b0000, Generated = q, Reference = 3'b001
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b001)) begin
            $display("Mismatch at index 5: Inputs = ['High' "4'b0000"], Generated = ['q'], Reference = ["3'b001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = Low, 4'b0000, Generated = q, Reference = 3'b001
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b001)) begin
            $display("Mismatch at index 6: Inputs = ['Low' "4'b0000"], Generated = ['q'], Reference = ["3'b001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = High, 4'b0000, Generated = q, Reference = 3'b010
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b010)) begin
            $display("Mismatch at index 7: Inputs = ['High' "4'b0000"], Generated = ['q'], Reference = ["3'b010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = Low, 4'b0000, Generated = q, Reference = 3'b010
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b010)) begin
            $display("Mismatch at index 8: Inputs = ['Low' "4'b0000"], Generated = ['q'], Reference = ["3'b010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = High, 4'b0000, Generated = q, Reference = 3'b011
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b011)) begin
            $display("Mismatch at index 9: Inputs = ['High' "4'b0000"], Generated = ['q'], Reference = ["3'b011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = Low, 4'b0001, Generated = q, Reference = 3'b011
        reset = 4'b0001; // Set input values
        #period;
        if (!(q === 3'b011)) begin
            $display("Mismatch at index 10: Inputs = ['Low' "4'b0001"], Generated = ['q'], Reference = ["3'b011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = High, 4'b0001, Generated = q, Reference = 3'b000
        reset = 4'b0001; // Set input values
        #period;
        if (!(q === 3'b000)) begin
            $display("Mismatch at index 11: Inputs = ['High' "4'b0001"], Generated = ['q'], Reference = ["3'b000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = Low, 4'b0001, Generated = q, Reference = 3'b000
        reset = 4'b0001; // Set input values
        #period;
        if (!(q === 3'b000)) begin
            $display("Mismatch at index 12: Inputs = ['Low' "4'b0001"], Generated = ['q'], Reference = ["3'b000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = High, 4'b0000, Generated = q, Reference = 3'b000
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b000)) begin
            $display("Mismatch at index 13: Inputs = ['High' "4'b0000"], Generated = ['q'], Reference = ["3'b000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = Low, 4'b0000, Generated = q, Reference = 3'b000
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b000)) begin
            $display("Mismatch at index 14: Inputs = ['Low' "4'b0000"], Generated = ['q'], Reference = ["3'b000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = High, 4'b0000, Generated = q, Reference = 3'b001
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b001)) begin
            $display("Mismatch at index 15: Inputs = ['High' "4'b0000"], Generated = ['q'], Reference = ["3'b001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = Low, 4'b0000, Generated = q, Reference = 3'b001
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b001)) begin
            $display("Mismatch at index 16: Inputs = ['Low' "4'b0000"], Generated = ['q'], Reference = ["3'b001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = High, 4'b0000, Generated = q, Reference = 3'b010
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b010)) begin
            $display("Mismatch at index 17: Inputs = ['High' "4'b0000"], Generated = ['q'], Reference = ["3'b010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = Low, 4'b0000, Generated = q, Reference = 3'b010
        reset = 4'b0000; // Set input values
        #period;
        if (!(q === 3'b010)) begin
            $display("Mismatch at index 18: Inputs = ['Low' "4'b0000"], Generated = ['q'], Reference = ["3'b010"]");
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