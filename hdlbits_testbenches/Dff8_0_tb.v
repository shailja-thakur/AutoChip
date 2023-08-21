`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg clk;
    reg [7:0] d;

    wire [7:0] q;


    integer mismatch_count;

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
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b1, 1'b10000001, Generated = q, Reference = 1'b100100
        d = 1'b10000001; // Set input values
        #period;
        if (!(q === 1'b100100)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10000001, q, 1'b100100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b0, 1'b1001, Generated = q, Reference = 1'b100100
        d = 1'b1001; // Set input values
        #period;
        if (!(q === 1'b100100)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b1001, q, 1'b100100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b1, 1'b1100011, Generated = q, Reference = 1'b1001
        d = 1'b1100011; // Set input values
        #period;
        if (!(q === 1'b1001)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b1100011, q, 1'b1001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b0, 1'b1101, Generated = q, Reference = 1'b1001
        d = 1'b1101; // Set input values
        #period;
        if (!(q === 1'b1001)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b1101, q, 1'b1001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b1, 1'b10001101, Generated = q, Reference = 1'b1101
        d = 1'b10001101; // Set input values
        #period;
        if (!(q === 1'b1101)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10001101, q, 1'b1101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b0, 1'b1100101, Generated = q, Reference = 1'b1101
        d = 1'b1100101; // Set input values
        #period;
        if (!(q === 1'b1101)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b1100101, q, 1'b1101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b1, 1'b10010, Generated = q, Reference = 1'b1100101
        d = 1'b10010; // Set input values
        #period;
        if (!(q === 1'b1100101)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10010, q, 1'b1100101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b0, 1'b1, Generated = q, Reference = 1'b1100101
        d = 1'b1; // Set input values
        #period;
        if (!(q === 1'b1100101)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b1, q, 1'b1100101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b1, 1'b1101, Generated = q, Reference = 1'b1
        d = 1'b1101; // Set input values
        #period;
        if (!(q === 1'b1)) begin
            $display("Mismatch at index 8: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b1101, q, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b0, 1'b1110110, Generated = q, Reference = 1'b1
        d = 1'b1110110; // Set input values
        #period;
        if (!(q === 1'b1)) begin
            $display("Mismatch at index 9: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b1110110, q, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 1'b1, 1'b111101, Generated = q, Reference = 1'b1110110
        d = 1'b111101; // Set input values
        #period;
        if (!(q === 1'b1110110)) begin
            $display("Mismatch at index 10: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b111101, q, 1'b1110110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 1'b0, 1'b11101101, Generated = q, Reference = 1'b1110110
        d = 1'b11101101; // Set input values
        #period;
        if (!(q === 1'b1110110)) begin
            $display("Mismatch at index 11: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b11101101, q, 1'b1110110);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 1'b1, 1'b10001100, Generated = q, Reference = 1'b11101101
        d = 1'b10001100; // Set input values
        #period;
        if (!(q === 1'b11101101)) begin
            $display("Mismatch at index 12: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10001100, q, 1'b11101101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 1'b0, 1'b11111001, Generated = q, Reference = 1'b11101101
        d = 1'b11111001; // Set input values
        #period;
        if (!(q === 1'b11101101)) begin
            $display("Mismatch at index 13: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b11111001, q, 1'b11101101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 1'b1, 1'b11000110, Generated = q, Reference = 1'b11111001
        d = 1'b11000110; // Set input values
        #period;
        if (!(q === 1'b11111001)) begin
            $display("Mismatch at index 14: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b11000110, q, 1'b11111001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 1'b0, 1'b11000101, Generated = q, Reference = 1'b11111001
        d = 1'b11000101; // Set input values
        #period;
        if (!(q === 1'b11111001)) begin
            $display("Mismatch at index 15: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b11000101, q, 1'b11111001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 1'b1, 1'b10101010, Generated = q, Reference = 1'b11000101
        d = 1'b10101010; // Set input values
        #period;
        if (!(q === 1'b11000101)) begin
            $display("Mismatch at index 16: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10101010, q, 1'b11000101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 1'b0, 1'b11100101, Generated = q, Reference = 1'b11000101
        d = 1'b11100101; // Set input values
        #period;
        if (!(q === 1'b11000101)) begin
            $display("Mismatch at index 17: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b11100101, q, 1'b11000101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 1'b1, 1'b1110111, Generated = q, Reference = 1'b11100101
        d = 1'b1110111; // Set input values
        #period;
        if (!(q === 1'b11100101)) begin
            $display("Mismatch at index 18: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b1110111, q, 1'b11100101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = 1'b0, 1'b10010, Generated = q, Reference = 1'b11100101
        d = 1'b10010; // Set input values
        #period;
        if (!(q === 1'b11100101)) begin
            $display("Mismatch at index 19: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b10010, q, 1'b11100101);
            mismatch_count = mismatch_count + 1;
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