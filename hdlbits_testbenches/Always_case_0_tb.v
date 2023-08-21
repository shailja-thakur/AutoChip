`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [2:0] sel;
    reg [3:0] data0;
    reg [3:0] data1;
    reg [3:0] data2;
    reg [3:0] data3;
    reg [3:0] data4;
    reg [3:0] data5;

    wire [3:0] out;


    integer mismatch_count;

    top_module UUT (.sel(sel), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .out(out));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b111, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b0
        sel = 1'b111; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b0)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b111, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b0, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1010
        sel = 1'b0; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1010)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1010);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b0, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1010
        sel = 1'b0; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1010)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1010);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b1, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1011
        sel = 1'b1; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1011)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1011);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b1, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1011
        sel = 1'b1; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1011)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1011);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b10, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1100
        sel = 1'b10; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1100)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b10, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1100);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b10, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1100
        sel = 1'b10; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1100)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b10, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1100);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b11, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1101
        sel = 1'b11; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1101)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b11, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1101);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b11, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1101
        sel = 1'b11; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1101)) begin
            $display("Mismatch at index 8: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b11, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1101);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b100, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1110
        sel = 1'b100; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1110)) begin
            $display("Mismatch at index 9: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b100, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1110);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 1'b100, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1110
        sel = 1'b100; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1110)) begin
            $display("Mismatch at index 10: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b100, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1110);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 1'b101, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1111
        sel = 1'b101; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1111)) begin
            $display("Mismatch at index 11: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b101, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 1'b101, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b1111
        sel = 1'b101; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b1111)) begin
            $display("Mismatch at index 12: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b101, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b1111);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 1'b110, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b0
        sel = 1'b110; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b0)) begin
            $display("Mismatch at index 13: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b110, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 1'b110, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b0
        sel = 1'b110; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b0)) begin
            $display("Mismatch at index 14: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b110, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 1'b111, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, Generated = out, Reference = 1'b0
        sel = 1'b111; data0 = 1'b1010; data1 = 1'b1011; data2 = 1'b1100; data3 = 1'b1101; data4 = 1'b1110; data5 = 1'b1111; // Set input values
        #period;
        if (!(out === 1'b0)) begin
            $display("Mismatch at index 15: Inputs = [%b, %b, %b, %b, %b, %b, %b], Generated = [%b], Reference = [%b]", 1'b111, 1'b1010, 1'b1011, 1'b1100, 1'b1101, 1'b1110, 1'b1111, out, 1'b0);
            mismatch_count = mismatch_count + 1;
            $finish;
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