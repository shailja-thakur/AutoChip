module top_module_tb;

    reg clk;
    reg resetn;
    reg [0:0] byteena;
    reg [14:0] d;

    wire [14:0] q;


    top_module UUT (.clk(clk), .resetn(resetn), .byteena(byteena), .d(d), .q(q));

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

        // Tick 0: Inputs = High, 4'b0000, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b000000000000000
        resetn = 4'b0000; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b000000000000000)) begin
            $display("Mismatch at index 0: Inputs = ['High' "4'b0000" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = Low, 4'b0000, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b000000000000000
        resetn = 4'b0000; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b000000000000000)) begin
            $display("Mismatch at index 1: Inputs = ['Low' "4'b0000" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = High, 4'b0000, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b000000000000000
        resetn = 4'b0000; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b000000000000000)) begin
            $display("Mismatch at index 2: Inputs = ['High' "4'b0000" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = Low, 4'b0000, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b000000000000000
        resetn = 4'b0000; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b000000000000000)) begin
            $display("Mismatch at index 3: Inputs = ['Low' "4'b0000" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = High, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b000000000000000
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b000000000000000)) begin
            $display("Mismatch at index 4: Inputs = ['High' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = Low, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b000000000000000
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b000000000000000)) begin
            $display("Mismatch at index 5: Inputs = ['Low' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = High, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b1010101111001101
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b1010101111001101)) begin
            $display("Mismatch at index 6: Inputs = ['High' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b1010101111001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = Low, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b1010101111001101
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b1010101111001101)) begin
            $display("Mismatch at index 7: Inputs = ['Low' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b1010101111001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = High, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b1010101111001101
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b1010101111001101)) begin
            $display("Mismatch at index 8: Inputs = ['High' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b1010101111001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = Low, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b1010101111001101
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b1010101111001101)) begin
            $display("Mismatch at index 9: Inputs = ['Low' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b1010101111001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = High, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b1010101111001101
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b1010101111001101)) begin
            $display("Mismatch at index 10: Inputs = ['High' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b1010101111001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = Low, 4'b0000, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b1010101111001101
        resetn = 4'b0000; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b1010101111001101)) begin
            $display("Mismatch at index 11: Inputs = ['Low' "4'b0000" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b1010101111001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = High, 4'b0000, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b000000000000000
        resetn = 4'b0000; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b000000000000000)) begin
            $display("Mismatch at index 12: Inputs = ['High' "4'b0000" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = Low, 4'b0000, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b000000000000000
        resetn = 4'b0000; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b000000000000000)) begin
            $display("Mismatch at index 13: Inputs = ['Low' "4'b0000" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = High, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b000000000000000
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b000000000000000)) begin
            $display("Mismatch at index 14: Inputs = ['High' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = Low, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b000000000000000
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b000000000000000)) begin
            $display("Mismatch at index 15: Inputs = ['Low' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = High, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b1010101111001101
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b1010101111001101)) begin
            $display("Mismatch at index 16: Inputs = ['High' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b1010101111001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = Low, 4'b0001, 1'b11, 15'b1010101111001101, Generated = q, Reference = 15'b1010101111001101
        resetn = 4'b0001; byteena = 1'b11; d = 15'b1010101111001101; // Set input values
        #period;
        if (!(q === 15'b1010101111001101)) begin
            $display("Mismatch at index 17: Inputs = ['Low' "4'b0001" "1'b11" "15'b1010101111001101"], Generated = ['q'], Reference = ["15'b1010101111001101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 18);
        $finish;
    end

endmodule