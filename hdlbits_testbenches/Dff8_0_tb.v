module top_module_tb;

    reg clk;
    reg [6:0] d;

    wire [6:0] q;


    top_module UUT (.clk(clk), .d(d), .q(q));

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

        // Tick 0: Inputs = High, 7'b10000001, Generated = q, Reference = 7'b0100100
        d = 7'b10000001; // Set input values
        #period;
        if (!(q === 7'b0100100)) begin
            $display("Mismatch at index 0: Inputs = ['High' "7'b10000001"], Generated = ['q'], Reference = ["7'b0100100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = Low, 7'b0001001, Generated = q, Reference = 7'b0100100
        d = 7'b0001001; // Set input values
        #period;
        if (!(q === 7'b0100100)) begin
            $display("Mismatch at index 1: Inputs = ['Low' "7'b0001001"], Generated = ['q'], Reference = ["7'b0100100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = High, 7'b1100011, Generated = q, Reference = 7'b0001001
        d = 7'b1100011; // Set input values
        #period;
        if (!(q === 7'b0001001)) begin
            $display("Mismatch at index 2: Inputs = ['High' "7'b1100011"], Generated = ['q'], Reference = ["7'b0001001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = Low, 7'b0001101, Generated = q, Reference = 7'b0001001
        d = 7'b0001101; // Set input values
        #period;
        if (!(q === 7'b0001001)) begin
            $display("Mismatch at index 3: Inputs = ['Low' "7'b0001101"], Generated = ['q'], Reference = ["7'b0001001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = High, 7'b10001101, Generated = q, Reference = 7'b0001101
        d = 7'b10001101; // Set input values
        #period;
        if (!(q === 7'b0001101)) begin
            $display("Mismatch at index 4: Inputs = ['High' "7'b10001101"], Generated = ['q'], Reference = ["7'b0001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = Low, 7'b1100101, Generated = q, Reference = 7'b0001101
        d = 7'b1100101; // Set input values
        #period;
        if (!(q === 7'b0001101)) begin
            $display("Mismatch at index 5: Inputs = ['Low' "7'b1100101"], Generated = ['q'], Reference = ["7'b0001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = High, 7'b0010010, Generated = q, Reference = 7'b1100101
        d = 7'b0010010; // Set input values
        #period;
        if (!(q === 7'b1100101)) begin
            $display("Mismatch at index 6: Inputs = ['High' "7'b0010010"], Generated = ['q'], Reference = ["7'b1100101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = Low, 7'b0000001, Generated = q, Reference = 7'b1100101
        d = 7'b0000001; // Set input values
        #period;
        if (!(q === 7'b1100101)) begin
            $display("Mismatch at index 7: Inputs = ['Low' "7'b0000001"], Generated = ['q'], Reference = ["7'b1100101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = High, 7'b0001101, Generated = q, Reference = 7'b0000001
        d = 7'b0001101; // Set input values
        #period;
        if (!(q === 7'b0000001)) begin
            $display("Mismatch at index 8: Inputs = ['High' "7'b0001101"], Generated = ['q'], Reference = ["7'b0000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = Low, 7'b1110110, Generated = q, Reference = 7'b0000001
        d = 7'b1110110; // Set input values
        #period;
        if (!(q === 7'b0000001)) begin
            $display("Mismatch at index 9: Inputs = ['Low' "7'b1110110"], Generated = ['q'], Reference = ["7'b0000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = High, 7'b0111101, Generated = q, Reference = 7'b1110110
        d = 7'b0111101; // Set input values
        #period;
        if (!(q === 7'b1110110)) begin
            $display("Mismatch at index 10: Inputs = ['High' "7'b0111101"], Generated = ['q'], Reference = ["7'b1110110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = Low, 7'b11101101, Generated = q, Reference = 7'b1110110
        d = 7'b11101101; // Set input values
        #period;
        if (!(q === 7'b1110110)) begin
            $display("Mismatch at index 11: Inputs = ['Low' "7'b11101101"], Generated = ['q'], Reference = ["7'b1110110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = High, 7'b10001100, Generated = q, Reference = 7'b11101101
        d = 7'b10001100; // Set input values
        #period;
        if (!(q === 7'b11101101)) begin
            $display("Mismatch at index 12: Inputs = ['High' "7'b10001100"], Generated = ['q'], Reference = ["7'b11101101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = Low, 7'b11111001, Generated = q, Reference = 7'b11101101
        d = 7'b11111001; // Set input values
        #period;
        if (!(q === 7'b11101101)) begin
            $display("Mismatch at index 13: Inputs = ['Low' "7'b11111001"], Generated = ['q'], Reference = ["7'b11101101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = High, 7'b11000110, Generated = q, Reference = 7'b11111001
        d = 7'b11000110; // Set input values
        #period;
        if (!(q === 7'b11111001)) begin
            $display("Mismatch at index 14: Inputs = ['High' "7'b11000110"], Generated = ['q'], Reference = ["7'b11111001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = Low, 7'b11000101, Generated = q, Reference = 7'b11111001
        d = 7'b11000101; // Set input values
        #period;
        if (!(q === 7'b11111001)) begin
            $display("Mismatch at index 15: Inputs = ['Low' "7'b11000101"], Generated = ['q'], Reference = ["7'b11111001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = High, 7'b10101010, Generated = q, Reference = 7'b11000101
        d = 7'b10101010; // Set input values
        #period;
        if (!(q === 7'b11000101)) begin
            $display("Mismatch at index 16: Inputs = ['High' "7'b10101010"], Generated = ['q'], Reference = ["7'b11000101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = Low, 7'b11100101, Generated = q, Reference = 7'b11000101
        d = 7'b11100101; // Set input values
        #period;
        if (!(q === 7'b11000101)) begin
            $display("Mismatch at index 17: Inputs = ['Low' "7'b11100101"], Generated = ['q'], Reference = ["7'b11000101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = High, 7'b1110111, Generated = q, Reference = 7'b11100101
        d = 7'b1110111; // Set input values
        #period;
        if (!(q === 7'b11100101)) begin
            $display("Mismatch at index 18: Inputs = ['High' "7'b1110111"], Generated = ['q'], Reference = ["7'b11100101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = Low, 7'b0010010, Generated = q, Reference = 7'b11100101
        d = 7'b0010010; // Set input values
        #period;
        if (!(q === 7'b11100101)) begin
            $display("Mismatch at index 19: Inputs = ['Low' "7'b0010010"], Generated = ['q'], Reference = ["7'b11100101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 20);
        $finish;
    end

endmodule