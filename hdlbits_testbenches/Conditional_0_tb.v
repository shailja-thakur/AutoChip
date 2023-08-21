module top_module_tb;

    reg [6:0] a;
    reg b;
    reg c;
    reg d;

    wire [6:0] min;


    top_module UUT (.a(a), .b(b), .c(c), .d(d), .min(min));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 7'b0000001, 8'b00000010, 8'b00000011, 8'b00000100, Generated = min, Reference = 7'b0000001
        a = 7'b0000001; b = 8'b00000010; c = 8'b00000011; d = 8'b00000100; // Set input values
        #period;
        if (!(min === 7'b0000001)) begin
            $display("Mismatch at index 0: Inputs = ["7'b0000001" "8'b00000010" "8'b00000011" "8'b00000100"], Generated = ['min'], Reference = ["7'b0000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 7'b0000001, 8'b00000010, 8'b00000011, 8'b00000100, Generated = min, Reference = 7'b0000001
        a = 7'b0000001; b = 8'b00000010; c = 8'b00000011; d = 8'b00000100; // Set input values
        #period;
        if (!(min === 7'b0000001)) begin
            $display("Mismatch at index 1: Inputs = ["7'b0000001" "8'b00000010" "8'b00000011" "8'b00000100"], Generated = ['min'], Reference = ["7'b0000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 7'b0000001, 8'b00000010, 8'b00000011, 8'b00000100, Generated = min, Reference = 7'b0000001
        a = 7'b0000001; b = 8'b00000010; c = 8'b00000011; d = 8'b00000100; // Set input values
        #period;
        if (!(min === 7'b0000001)) begin
            $display("Mismatch at index 2: Inputs = ["7'b0000001" "8'b00000010" "8'b00000011" "8'b00000100"], Generated = ['min'], Reference = ["7'b0000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 7'b0010001, 8'b00000010, 8'b00000011, 8'b00000100, Generated = min, Reference = 7'b0000010
        a = 7'b0010001; b = 8'b00000010; c = 8'b00000011; d = 8'b00000100; // Set input values
        #period;
        if (!(min === 7'b0000010)) begin
            $display("Mismatch at index 3: Inputs = ["7'b0010001" "8'b00000010" "8'b00000011" "8'b00000100"], Generated = ['min'], Reference = ["7'b0000010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 7'b0010001, 8'b00000010, 8'b00000011, 8'b00000100, Generated = min, Reference = 7'b0000010
        a = 7'b0010001; b = 8'b00000010; c = 8'b00000011; d = 8'b00000100; // Set input values
        #period;
        if (!(min === 7'b0000010)) begin
            $display("Mismatch at index 4: Inputs = ["7'b0010001" "8'b00000010" "8'b00000011" "8'b00000100"], Generated = ['min'], Reference = ["7'b0000010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 7'b0010001, 8'b00010010, 8'b00000011, 8'b00000100, Generated = min, Reference = 7'b0000011
        a = 7'b0010001; b = 8'b00010010; c = 8'b00000011; d = 8'b00000100; // Set input values
        #period;
        if (!(min === 7'b0000011)) begin
            $display("Mismatch at index 5: Inputs = ["7'b0010001" "8'b00010010" "8'b00000011" "8'b00000100"], Generated = ['min'], Reference = ["7'b0000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 7'b0010001, 8'b00010010, 8'b00000011, 8'b00000100, Generated = min, Reference = 7'b0000011
        a = 7'b0010001; b = 8'b00010010; c = 8'b00000011; d = 8'b00000100; // Set input values
        #period;
        if (!(min === 7'b0000011)) begin
            $display("Mismatch at index 6: Inputs = ["7'b0010001" "8'b00010010" "8'b00000011" "8'b00000100"], Generated = ['min'], Reference = ["7'b0000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 7'b0010001, 8'b00010010, 8'b00010011, 8'b00000100, Generated = min, Reference = 7'b0000100
        a = 7'b0010001; b = 8'b00010010; c = 8'b00010011; d = 8'b00000100; // Set input values
        #period;
        if (!(min === 7'b0000100)) begin
            $display("Mismatch at index 7: Inputs = ["7'b0010001" "8'b00010010" "8'b00010011" "8'b00000100"], Generated = ['min'], Reference = ["7'b0000100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 7'b0010001, 8'b00010010, 8'b00010011, 8'b00000100, Generated = min, Reference = 7'b0000100
        a = 7'b0010001; b = 8'b00010010; c = 8'b00010011; d = 8'b00000100; // Set input values
        #period;
        if (!(min === 7'b0000100)) begin
            $display("Mismatch at index 8: Inputs = ["7'b0010001" "8'b00010010" "8'b00010011" "8'b00000100"], Generated = ['min'], Reference = ["7'b0000100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 7'b0010001, 8'b00010010, 8'b00010011, 8'b00010100, Generated = min, Reference = 7'b0010001
        a = 7'b0010001; b = 8'b00010010; c = 8'b00010011; d = 8'b00010100; // Set input values
        #period;
        if (!(min === 7'b0010001)) begin
            $display("Mismatch at index 9: Inputs = ["7'b0010001" "8'b00010010" "8'b00010011" "8'b00010100"], Generated = ['min'], Reference = ["7'b0010001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
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