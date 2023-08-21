`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [7:0] a;
    reg [7:0] b;
    reg [7:0] c;
    reg [7:0] d;

    wire [7:0] min;


    integer mismatch_count;

    top_module UUT (.a(a), .b(b), .c(c), .d(d), .min(min));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b1, 1'b10, 1'b11, 1'b100, Generated = min, Reference = 1'b1
        a = 1'b1; b = 1'b10; c = 1'b11; d = 1'b100; // Set input values
        #period;
        if (!(min === 1'b1)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b11, 1'b100, min, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b1, 1'b10, 1'b11, 1'b100, Generated = min, Reference = 1'b1
        a = 1'b1; b = 1'b10; c = 1'b11; d = 1'b100; // Set input values
        #period;
        if (!(min === 1'b1)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b11, 1'b100, min, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b1, 1'b10, 1'b11, 1'b100, Generated = min, Reference = 1'b1
        a = 1'b1; b = 1'b10; c = 1'b11; d = 1'b100; // Set input values
        #period;
        if (!(min === 1'b1)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, 1'b11, 1'b100, min, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b10001, 1'b10, 1'b11, 1'b100, Generated = min, Reference = 1'b10
        a = 1'b10001; b = 1'b10; c = 1'b11; d = 1'b100; // Set input values
        #period;
        if (!(min === 1'b10)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b10001, 1'b10, 1'b11, 1'b100, min, 1'b10);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b10001, 1'b10, 1'b11, 1'b100, Generated = min, Reference = 1'b10
        a = 1'b10001; b = 1'b10; c = 1'b11; d = 1'b100; // Set input values
        #period;
        if (!(min === 1'b10)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b10001, 1'b10, 1'b11, 1'b100, min, 1'b10);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b10001, 1'b10010, 1'b11, 1'b100, Generated = min, Reference = 1'b11
        a = 1'b10001; b = 1'b10010; c = 1'b11; d = 1'b100; // Set input values
        #period;
        if (!(min === 1'b11)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b10001, 1'b10010, 1'b11, 1'b100, min, 1'b11);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b10001, 1'b10010, 1'b11, 1'b100, Generated = min, Reference = 1'b11
        a = 1'b10001; b = 1'b10010; c = 1'b11; d = 1'b100; // Set input values
        #period;
        if (!(min === 1'b11)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b10001, 1'b10010, 1'b11, 1'b100, min, 1'b11);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b10001, 1'b10010, 1'b10011, 1'b100, Generated = min, Reference = 1'b100
        a = 1'b10001; b = 1'b10010; c = 1'b10011; d = 1'b100; // Set input values
        #period;
        if (!(min === 1'b100)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b10001, 1'b10010, 1'b10011, 1'b100, min, 1'b100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b10001, 1'b10010, 1'b10011, 1'b100, Generated = min, Reference = 1'b100
        a = 1'b10001; b = 1'b10010; c = 1'b10011; d = 1'b100; // Set input values
        #period;
        if (!(min === 1'b100)) begin
            $display("Mismatch at index 8: Inputs = [%b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b10001, 1'b10010, 1'b10011, 1'b100, min, 1'b100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b10001, 1'b10010, 1'b10011, 1'b10100, Generated = min, Reference = 1'b10001
        a = 1'b10001; b = 1'b10010; c = 1'b10011; d = 1'b10100; // Set input values
        #period;
        if (!(min === 1'b10001)) begin
            $display("Mismatch at index 9: Inputs = [%b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b10001, 1'b10010, 1'b10011, 1'b10100, min, 1'b10001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 10);
        $finish;
    end

endmodule