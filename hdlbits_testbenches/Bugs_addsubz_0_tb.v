`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg do_sub;
    reg [7:0] a;
    reg [7:0] b;

    wire [7:0] out;
    wire result_is_zero;


    top_module UUT (.do_sub(do_sub), .a(a), .b(b), .out(out), .result_is_zero(result_is_zero));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 4'b0000, 8'b10101010, 8'b10111011, Generated = out, result_is_zero, Reference = 8'b01100101, 4'b0000
        do_sub = 4'b0000; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b01100101 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 0: Inputs = ["4'b0000" "8'b10101010" "8'b10111011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b01100101", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 4'b0000, 8'b10101010, 8'b10111011, Generated = out, result_is_zero, Reference = 8'b01100101, 4'b0000
        do_sub = 4'b0000; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b01100101 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 1: Inputs = ["4'b0000" "8'b10101010" "8'b10111011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b01100101", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 4'b0000, 8'b10101010, 8'b10111011, Generated = out, result_is_zero, Reference = 8'b01100101, 4'b0000
        do_sub = 4'b0000; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b01100101 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 2: Inputs = ["4'b0000" "8'b10101010" "8'b10111011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b01100101", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 4'b0001, 8'b10101010, 8'b10111011, Generated = out, result_is_zero, Reference = 8'b11101111, 4'b0000
        do_sub = 4'b0001; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b11101111 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 3: Inputs = ["4'b0001" "8'b10101010" "8'b10111011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b11101111", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 4'b0001, 8'b10101010, 8'b10111011, Generated = out, result_is_zero, Reference = 8'b11101111, 4'b0000
        do_sub = 4'b0001; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b11101111 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 4: Inputs = ["4'b0001" "8'b10101010" "8'b10111011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b11101111", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 4'b0000, 8'b00000011, 8'b00000011, Generated = out, result_is_zero, Reference = 8'b00000110, 4'b0000
        do_sub = 4'b0000; a = 8'b00000011; b = 8'b00000011; // Set input values
        #period;
        if (!(out === 8'b00000110 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 5: Inputs = ["4'b0000" "8'b00000011" "8'b00000011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b00000110", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 4'b0000, 8'b00000011, 8'b00000011, Generated = out, result_is_zero, Reference = 8'b00000110, 4'b0000
        do_sub = 4'b0000; a = 8'b00000011; b = 8'b00000011; // Set input values
        #period;
        if (!(out === 8'b00000110 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 6: Inputs = ["4'b0000" "8'b00000011" "8'b00000011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b00000110", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 4'b0001, 8'b00000011, 8'b00000011, Generated = out, result_is_zero, Reference = 8'b00000000, 4'b0001
        do_sub = 4'b0001; a = 8'b00000011; b = 8'b00000011; // Set input values
        #period;
        if (!(out === 8'b00000000 && result_is_zero === 4'b0001)) begin
            $display("Mismatch at index 7: Inputs = ["4'b0001" "8'b00000011" "8'b00000011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b00000000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 4'b0000, 8'b00000011, 8'b00000100, Generated = out, result_is_zero, Reference = 8'b00000111, 4'b0000
        do_sub = 4'b0000; a = 8'b00000011; b = 8'b00000100; // Set input values
        #period;
        if (!(out === 8'b00000111 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 8: Inputs = ["4'b0000" "8'b00000011" "8'b00000100"], Generated = ['out', 'result_is_zero'], Reference = ["8'b00000111", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 4'b0000, 8'b00000011, 8'b00000100, Generated = out, result_is_zero, Reference = 8'b00000111, 4'b0000
        do_sub = 4'b0000; a = 8'b00000011; b = 8'b00000100; // Set input values
        #period;
        if (!(out === 8'b00000111 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 9: Inputs = ["4'b0000" "8'b00000011" "8'b00000100"], Generated = ['out', 'result_is_zero'], Reference = ["8'b00000111", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 4'b0001, 8'b00000011, 8'b00000100, Generated = out, result_is_zero, Reference = 8'b11111111, 4'b0000
        do_sub = 4'b0001; a = 8'b00000011; b = 8'b00000100; // Set input values
        #period;
        if (!(out === 8'b11111111 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 10: Inputs = ["4'b0001" "8'b00000011" "8'b00000100"], Generated = ['out', 'result_is_zero'], Reference = ["8'b11111111", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 4'b0000, 8'b11111101, 8'b00000011, Generated = out, result_is_zero, Reference = 8'b00000000, 4'b0001
        do_sub = 4'b0000; a = 8'b11111101; b = 8'b00000011; // Set input values
        #period;
        if (!(out === 8'b00000000 && result_is_zero === 4'b0001)) begin
            $display("Mismatch at index 11: Inputs = ["4'b0000" "8'b11111101" "8'b00000011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b00000000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 4'b0000, 8'b11111101, 8'b00000011, Generated = out, result_is_zero, Reference = 8'b00000000, 4'b0001
        do_sub = 4'b0000; a = 8'b11111101; b = 8'b00000011; // Set input values
        #period;
        if (!(out === 8'b00000000 && result_is_zero === 4'b0001)) begin
            $display("Mismatch at index 12: Inputs = ["4'b0000" "8'b11111101" "8'b00000011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b00000000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 4'b0001, 8'b11111101, 8'b00000011, Generated = out, result_is_zero, Reference = 8'b11111010, 4'b0000
        do_sub = 4'b0001; a = 8'b11111101; b = 8'b00000011; // Set input values
        #period;
        if (!(out === 8'b11111010 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 13: Inputs = ["4'b0001" "8'b11111101" "8'b00000011"], Generated = ['out', 'result_is_zero'], Reference = ["8'b11111010", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 4'b0000, 8'b11111101, 8'b00000100, Generated = out, result_is_zero, Reference = 8'b00000001, 4'b0000
        do_sub = 4'b0000; a = 8'b11111101; b = 8'b00000100; // Set input values
        #period;
        if (!(out === 8'b00000001 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 14: Inputs = ["4'b0000" "8'b11111101" "8'b00000100"], Generated = ['out', 'result_is_zero'], Reference = ["8'b00000001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 4'b0000, 8'b11111101, 8'b00000100, Generated = out, result_is_zero, Reference = 8'b00000001, 4'b0000
        do_sub = 4'b0000; a = 8'b11111101; b = 8'b00000100; // Set input values
        #period;
        if (!(out === 8'b00000001 && result_is_zero === 4'b0000)) begin
            $display("Mismatch at index 15: Inputs = ["4'b0000" "8'b11111101" "8'b00000100"], Generated = ['out', 'result_is_zero'], Reference = ["8'b00000001", "4'b0000"]");
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