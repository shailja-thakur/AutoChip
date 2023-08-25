`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [5:0] y;
    reg w;

    wire Y2;
    wire Y4;


    integer mismatch_count;

    top_module UUT (.y(y), .w(w), .Y2(Y2), .Y4(Y4));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 6'b000100, 1'b1, Generated = Y2, Y4, Reference = 1'b0, 1'b1
        y = 6'b000100; w = 1'b1; // Set input values
        #period;
        if (!(Y2 === 1'b0 && Y4 === 1'b1)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b], Generated = [%b, %b], Reference = [%b, %b]", 6'b000100, 1'b1, Y2, Y4, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 6'b000010, 1'b1, Generated = Y2, Y4, Reference = 1'b0, 1'b1
        y = 6'b000010; w = 1'b1; // Set input values
        #period;
        if (!(Y2 === 1'b0 && Y4 === 1'b1)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b], Generated = [%b, %b], Reference = [%b, %b]", 6'b000010, 1'b1, Y2, Y4, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 6'b001000, 1'b1, Generated = Y2, Y4, Reference = 1'b0, 1'b0
        y = 6'b001000; w = 1'b1; // Set input values
        #period;
        if (!(Y2 === 1'b0 && Y4 === 1'b0)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b], Generated = [%b, %b], Reference = [%b, %b]", 6'b001000, 1'b1, Y2, Y4, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 6'b100000, 1'b0, Generated = Y2, Y4, Reference = 1'b0, 1'b0
        y = 6'b100000; w = 1'b0; // Set input values
        #period;
        if (!(Y2 === 1'b0 && Y4 === 1'b0)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b], Generated = [%b, %b], Reference = [%b, %b]", 6'b100000, 1'b0, Y2, Y4, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 6'b001000, 1'b1, Generated = Y2, Y4, Reference = 1'b0, 1'b0
        y = 6'b001000; w = 1'b1; // Set input values
        #period;
        if (!(Y2 === 1'b0 && Y4 === 1'b0)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b], Generated = [%b, %b], Reference = [%b, %b]", 6'b001000, 1'b1, Y2, Y4, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 6'b000001, 1'b1, Generated = Y2, Y4, Reference = 1'b0, 1'b0
        y = 6'b000001; w = 1'b1; // Set input values
        #period;
        if (!(Y2 === 1'b0 && Y4 === 1'b0)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b], Generated = [%b, %b], Reference = [%b, %b]", 6'b000001, 1'b1, Y2, Y4, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 6'b001000, 1'b0, Generated = Y2, Y4, Reference = 1'b0, 1'b0
        y = 6'b001000; w = 1'b0; // Set input values
        #period;
        if (!(Y2 === 1'b0 && Y4 === 1'b0)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b], Generated = [%b, %b], Reference = [%b, %b]", 6'b001000, 1'b0, Y2, Y4, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 6'b000010, 1'b0, Generated = Y2, Y4, Reference = 1'b0, 1'b0
        y = 6'b000010; w = 1'b0; // Set input values
        #period;
        if (!(Y2 === 1'b0 && Y4 === 1'b0)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b], Generated = [%b, %b], Reference = [%b, %b]", 6'b000010, 1'b0, Y2, Y4, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
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