`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg sel;
    reg [7:0] a;
    reg [7:0] b;

    wire [7:0] out;


    top_module UUT (.sel(sel), .a(a), .b(b), .out(out));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 4'b0000, 8'b00000000, 8'b00000000, Generated = out, Reference = 8'b00000000
        sel = 4'b0000; a = 8'b00000000; b = 8'b00000000; // Set input values
        #period;
        if (!(out === 8'b00000000)) begin
            $display("Mismatch at index 0: Inputs = ["4'b0000" "8'b00000000" "8'b00000000"], Generated = ['out'], Reference = ["8'b00000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 4'b0000, 8'b10101010, 8'b10111011, Generated = out, Reference = 8'b10111011
        sel = 4'b0000; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b10111011)) begin
            $display("Mismatch at index 1: Inputs = ["4'b0000" "8'b10101010" "8'b10111011"], Generated = ['out'], Reference = ["8'b10111011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 4'b0000, 8'b10101010, 8'b10111011, Generated = out, Reference = 8'b10111011
        sel = 4'b0000; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b10111011)) begin
            $display("Mismatch at index 2: Inputs = ["4'b0000" "8'b10101010" "8'b10111011"], Generated = ['out'], Reference = ["8'b10111011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 4'b0001, 8'b10101010, 8'b10111011, Generated = out, Reference = 8'b10101010
        sel = 4'b0001; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b10101010)) begin
            $display("Mismatch at index 3: Inputs = ["4'b0001" "8'b10101010" "8'b10111011"], Generated = ['out'], Reference = ["8'b10101010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 4'b0000, 8'b10101010, 8'b10111011, Generated = out, Reference = 8'b10111011
        sel = 4'b0000; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b10111011)) begin
            $display("Mismatch at index 4: Inputs = ["4'b0000" "8'b10101010" "8'b10111011"], Generated = ['out'], Reference = ["8'b10111011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 4'b0001, 8'b10101010, 8'b10111011, Generated = out, Reference = 8'b10101010
        sel = 4'b0001; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b10101010)) begin
            $display("Mismatch at index 5: Inputs = ["4'b0001" "8'b10101010" "8'b10111011"], Generated = ['out'], Reference = ["8'b10101010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 4'b0001, 8'b10101010, 8'b10111011, Generated = out, Reference = 8'b10101010
        sel = 4'b0001; a = 8'b10101010; b = 8'b10111011; // Set input values
        #period;
        if (!(out === 8'b10101010)) begin
            $display("Mismatch at index 6: Inputs = ["4'b0001" "8'b10101010" "8'b10111011"], Generated = ['out'], Reference = ["8'b10101010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 4'b0000, 8'b11111111, 8'b00000000, Generated = out, Reference = 8'b00000000
        sel = 4'b0000; a = 8'b11111111; b = 8'b00000000; // Set input values
        #period;
        if (!(out === 8'b00000000)) begin
            $display("Mismatch at index 7: Inputs = ["4'b0000" "8'b11111111" "8'b00000000"], Generated = ['out'], Reference = ["8'b00000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 4'b0000, 8'b11111111, 8'b00000000, Generated = out, Reference = 8'b00000000
        sel = 4'b0000; a = 8'b11111111; b = 8'b00000000; // Set input values
        #period;
        if (!(out === 8'b00000000)) begin
            $display("Mismatch at index 8: Inputs = ["4'b0000" "8'b11111111" "8'b00000000"], Generated = ['out'], Reference = ["8'b00000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 4'b0001, 8'b11111111, 8'b00000000, Generated = out, Reference = 8'b11111111
        sel = 4'b0001; a = 8'b11111111; b = 8'b00000000; // Set input values
        #period;
        if (!(out === 8'b11111111)) begin
            $display("Mismatch at index 9: Inputs = ["4'b0001" "8'b11111111" "8'b00000000"], Generated = ['out'], Reference = ["8'b11111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 4'b0000, 8'b11111111, 8'b00000000, Generated = out, Reference = 8'b00000000
        sel = 4'b0000; a = 8'b11111111; b = 8'b00000000; // Set input values
        #period;
        if (!(out === 8'b00000000)) begin
            $display("Mismatch at index 10: Inputs = ["4'b0000" "8'b11111111" "8'b00000000"], Generated = ['out'], Reference = ["8'b00000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 4'b0001, 8'b11111111, 8'b00000000, Generated = out, Reference = 8'b11111111
        sel = 4'b0001; a = 8'b11111111; b = 8'b00000000; // Set input values
        #period;
        if (!(out === 8'b11111111)) begin
            $display("Mismatch at index 11: Inputs = ["4'b0001" "8'b11111111" "8'b00000000"], Generated = ['out'], Reference = ["8'b11111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 12);
        $finish;
    end

endmodule