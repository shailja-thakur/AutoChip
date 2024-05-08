`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg a;
    reg b;

    wire sum;


    integer mismatch_count;

    top_module UUT (.a(a), .b(b), .sum(sum));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b0, 1'b0, Generated = sum, Reference = 5'b00000
        a = 1'b0; b = 1'b0; // Set input values
        #period;
        if (!(sum === 5'b00000)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, sum, 5'b00000);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b0, 1'b1, Generated = sum, Reference = 5'b00001
        a = 1'b0; b = 1'b1; // Set input values
        #period;
        if (!(sum === 5'b00001)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b1, sum, 5'b00001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b0, 1'b10, Generated = sum, Reference = 5'b00010
        a = 1'b0; b = 1'b10; // Set input values
        #period;
        if (!(sum === 5'b00010)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b10, sum, 5'b00010);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b1, 1'b10, Generated = sum, Reference = 5'b00011
        a = 1'b1; b = 1'b10; // Set input values
        #period;
        if (!(sum === 5'b00011)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b10, sum, 5'b00011);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b1111111111111111, 1'b0, Generated = sum, Reference = 5'b1111111111111111
        a = 1'b1111111111111111; b = 1'b0; // Set input values
        #period;
        if (!(sum === 5'b1111111111111111)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1111111111111111, 1'b0, sum, 5'b1111111111111111);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b1111111111111111, 1'b1, Generated = sum, Reference = 5'b10000000000000000
        a = 1'b1111111111111111; b = 1'b1; // Set input values
        #period;
        if (!(sum === 5'b10000000000000000)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1111111111111111, 1'b1, sum, 5'b10000000000000000);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b1111111111111111, 1'b101100110011000001, Generated = sum, Reference = 5'b111100110011000000
        a = 1'b1111111111111111; b = 1'b101100110011000001; // Set input values
        #period;
        if (!(sum === 5'b111100110011000000)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1111111111111111, 1'b101100110011000001, sum, 5'b111100110011000000);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 7);
        $finish;
    end

endmodule