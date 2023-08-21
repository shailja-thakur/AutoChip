`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg [2:0] vec;

    wire [2:0] outv;
    wire o2;
    wire o1;
    wire o0;


    top_module UUT (.vec(vec), .outv(outv), .o2(o2), .o1(o1), .o0(o0));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 3'b000, Generated = outv, o2, o1, o0, Reference = 3'b000, 4'b0000, 4'b0000, 4'b0000
        vec = 3'b000; // Set input values
        #period;
        if (!(outv === 3'b000 && o2 === 4'b0000 && o1 === 4'b0000 && o0 === 4'b0000)) begin
            $display("Mismatch at index 0: Inputs = ["3'b000"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 3'b000, Generated = outv, o2, o1, o0, Reference = 3'b000, 4'b0000, 4'b0000, 4'b0000
        vec = 3'b000; // Set input values
        #period;
        if (!(outv === 3'b000 && o2 === 4'b0000 && o1 === 4'b0000 && o0 === 4'b0000)) begin
            $display("Mismatch at index 1: Inputs = ["3'b000"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 3'b000, Generated = outv, o2, o1, o0, Reference = 3'b000, 4'b0000, 4'b0000, 4'b0000
        vec = 3'b000; // Set input values
        #period;
        if (!(outv === 3'b000 && o2 === 4'b0000 && o1 === 4'b0000 && o0 === 4'b0000)) begin
            $display("Mismatch at index 2: Inputs = ["3'b000"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 3'b001, Generated = outv, o2, o1, o0, Reference = 3'b001, 4'b0000, 4'b0000, 4'b0001
        vec = 3'b001; // Set input values
        #period;
        if (!(outv === 3'b001 && o2 === 4'b0000 && o1 === 4'b0000 && o0 === 4'b0001)) begin
            $display("Mismatch at index 3: Inputs = ["3'b001"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b001", "4'b0000", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 3'b001, Generated = outv, o2, o1, o0, Reference = 3'b001, 4'b0000, 4'b0000, 4'b0001
        vec = 3'b001; // Set input values
        #period;
        if (!(outv === 3'b001 && o2 === 4'b0000 && o1 === 4'b0000 && o0 === 4'b0001)) begin
            $display("Mismatch at index 4: Inputs = ["3'b001"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b001", "4'b0000", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 3'b010, Generated = outv, o2, o1, o0, Reference = 3'b010, 4'b0000, 4'b0001, 4'b0000
        vec = 3'b010; // Set input values
        #period;
        if (!(outv === 3'b010 && o2 === 4'b0000 && o1 === 4'b0001 && o0 === 4'b0000)) begin
            $display("Mismatch at index 5: Inputs = ["3'b010"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b010", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 3'b010, Generated = outv, o2, o1, o0, Reference = 3'b010, 4'b0000, 4'b0001, 4'b0000
        vec = 3'b010; // Set input values
        #period;
        if (!(outv === 3'b010 && o2 === 4'b0000 && o1 === 4'b0001 && o0 === 4'b0000)) begin
            $display("Mismatch at index 6: Inputs = ["3'b010"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b010", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 3'b011, Generated = outv, o2, o1, o0, Reference = 3'b011, 4'b0000, 4'b0001, 4'b0001
        vec = 3'b011; // Set input values
        #period;
        if (!(outv === 3'b011 && o2 === 4'b0000 && o1 === 4'b0001 && o0 === 4'b0001)) begin
            $display("Mismatch at index 7: Inputs = ["3'b011"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b011", "4'b0000", "4'b0001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 3'b011, Generated = outv, o2, o1, o0, Reference = 3'b011, 4'b0000, 4'b0001, 4'b0001
        vec = 3'b011; // Set input values
        #period;
        if (!(outv === 3'b011 && o2 === 4'b0000 && o1 === 4'b0001 && o0 === 4'b0001)) begin
            $display("Mismatch at index 8: Inputs = ["3'b011"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b011", "4'b0000", "4'b0001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 3'b100, Generated = outv, o2, o1, o0, Reference = 3'b100, 4'b0001, 4'b0000, 4'b0000
        vec = 3'b100; // Set input values
        #period;
        if (!(outv === 3'b100 && o2 === 4'b0001 && o1 === 4'b0000 && o0 === 4'b0000)) begin
            $display("Mismatch at index 9: Inputs = ["3'b100"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b100", "4'b0001", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 3'b100, Generated = outv, o2, o1, o0, Reference = 3'b100, 4'b0001, 4'b0000, 4'b0000
        vec = 3'b100; // Set input values
        #period;
        if (!(outv === 3'b100 && o2 === 4'b0001 && o1 === 4'b0000 && o0 === 4'b0000)) begin
            $display("Mismatch at index 10: Inputs = ["3'b100"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b100", "4'b0001", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 3'b101, Generated = outv, o2, o1, o0, Reference = 3'b101, 4'b0001, 4'b0000, 4'b0001
        vec = 3'b101; // Set input values
        #period;
        if (!(outv === 3'b101 && o2 === 4'b0001 && o1 === 4'b0000 && o0 === 4'b0001)) begin
            $display("Mismatch at index 11: Inputs = ["3'b101"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b101", "4'b0001", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 3'b101, Generated = outv, o2, o1, o0, Reference = 3'b101, 4'b0001, 4'b0000, 4'b0001
        vec = 3'b101; // Set input values
        #period;
        if (!(outv === 3'b101 && o2 === 4'b0001 && o1 === 4'b0000 && o0 === 4'b0001)) begin
            $display("Mismatch at index 12: Inputs = ["3'b101"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b101", "4'b0001", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 3'b110, Generated = outv, o2, o1, o0, Reference = 3'b110, 4'b0001, 4'b0001, 4'b0000
        vec = 3'b110; // Set input values
        #period;
        if (!(outv === 3'b110 && o2 === 4'b0001 && o1 === 4'b0001 && o0 === 4'b0000)) begin
            $display("Mismatch at index 13: Inputs = ["3'b110"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b110", "4'b0001", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 3'b110, Generated = outv, o2, o1, o0, Reference = 3'b110, 4'b0001, 4'b0001, 4'b0000
        vec = 3'b110; // Set input values
        #period;
        if (!(outv === 3'b110 && o2 === 4'b0001 && o1 === 4'b0001 && o0 === 4'b0000)) begin
            $display("Mismatch at index 14: Inputs = ["3'b110"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b110", "4'b0001", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 3'b111, Generated = outv, o2, o1, o0, Reference = 3'b111, 4'b0001, 4'b0001, 4'b0001
        vec = 3'b111; // Set input values
        #period;
        if (!(outv === 3'b111 && o2 === 4'b0001 && o1 === 4'b0001 && o0 === 4'b0001)) begin
            $display("Mismatch at index 15: Inputs = ["3'b111"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b111", "4'b0001", "4'b0001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 3'b111, Generated = outv, o2, o1, o0, Reference = 3'b111, 4'b0001, 4'b0001, 4'b0001
        vec = 3'b111; // Set input values
        #period;
        if (!(outv === 3'b111 && o2 === 4'b0001 && o1 === 4'b0001 && o0 === 4'b0001)) begin
            $display("Mismatch at index 16: Inputs = ["3'b111"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b111", "4'b0001", "4'b0001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 3'b000, Generated = outv, o2, o1, o0, Reference = 3'b000, 4'b0000, 4'b0000, 4'b0000
        vec = 3'b000; // Set input values
        #period;
        if (!(outv === 3'b000 && o2 === 4'b0000 && o1 === 4'b0000 && o0 === 4'b0000)) begin
            $display("Mismatch at index 17: Inputs = ["3'b000"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 3'b000, Generated = outv, o2, o1, o0, Reference = 3'b000, 4'b0000, 4'b0000, 4'b0000
        vec = 3'b000; // Set input values
        #period;
        if (!(outv === 3'b000 && o2 === 4'b0000 && o1 === 4'b0000 && o0 === 4'b0000)) begin
            $display("Mismatch at index 18: Inputs = ["3'b000"], Generated = ['outv', 'o2', 'o1', 'o0'], Reference = ["3'b000", "4'b0000", "4'b0000", "4'b0000"]");
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