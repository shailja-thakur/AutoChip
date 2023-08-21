module top_module_tb;

    reg [2:0] a;
    reg [2:0] b;
    reg [2:0] c;
    reg [2:0] d;
    reg [2:0] e;

    wire [2:0] q;


    top_module UUT (.a(a), .b(b), .c(c), .d(d), .e(e), .q(q));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 3'b1010, 3'b1011, 3'b010, 3'b1101, 3'b1110, Generated = q, Reference = 3'b1010
        a = 3'b1010; b = 3'b1011; c = 3'b010; d = 3'b1101; e = 3'b1110; // Set input values
        #period;
        if (!(q === 3'b1010)) begin
            $display("Mismatch at index 0: Inputs = ["3'b1010" "3'b1011" "3'b010" "3'b1101" "3'b1110"], Generated = ['q'], Reference = ["3'b1010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 3'b001, 3'b010, 3'b000, 3'b011, 3'b100, Generated = q, Reference = 3'b010
        a = 3'b001; b = 3'b010; c = 3'b000; d = 3'b011; e = 3'b100; // Set input values
        #period;
        if (!(q === 3'b010)) begin
            $display("Mismatch at index 1: Inputs = ["3'b001" "3'b010" "3'b000" "3'b011" "3'b100"], Generated = ['q'], Reference = ["3'b010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 3'b001, 3'b010, 3'b001, 3'b011, 3'b100, Generated = q, Reference = 3'b100
        a = 3'b001; b = 3'b010; c = 3'b001; d = 3'b011; e = 3'b100; // Set input values
        #period;
        if (!(q === 3'b100)) begin
            $display("Mismatch at index 2: Inputs = ["3'b001" "3'b010" "3'b001" "3'b011" "3'b100"], Generated = ['q'], Reference = ["3'b100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 3'b001, 3'b010, 3'b010, 3'b011, 3'b100, Generated = q, Reference = 3'b001
        a = 3'b001; b = 3'b010; c = 3'b010; d = 3'b011; e = 3'b100; // Set input values
        #period;
        if (!(q === 3'b001)) begin
            $display("Mismatch at index 3: Inputs = ["3'b001" "3'b010" "3'b010" "3'b011" "3'b100"], Generated = ['q'], Reference = ["3'b001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 3'b001, 3'b010, 3'b011, 3'b011, 3'b100, Generated = q, Reference = 3'b011
        a = 3'b001; b = 3'b010; c = 3'b011; d = 3'b011; e = 3'b100; // Set input values
        #period;
        if (!(q === 3'b011)) begin
            $display("Mismatch at index 4: Inputs = ["3'b001" "3'b010" "3'b011" "3'b011" "3'b100"], Generated = ['q'], Reference = ["3'b011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 3'b001, 3'b010, 3'b100, 3'b011, 3'b100, Generated = q, Reference = 3'b1111
        a = 3'b001; b = 3'b010; c = 3'b100; d = 3'b011; e = 3'b100; // Set input values
        #period;
        if (!(q === 3'b1111)) begin
            $display("Mismatch at index 5: Inputs = ["3'b001" "3'b010" "3'b100" "3'b011" "3'b100"], Generated = ['q'], Reference = ["3'b1111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 3'b001, 3'b010, 3'b101, 3'b011, 3'b100, Generated = q, Reference = 3'b1111
        a = 3'b001; b = 3'b010; c = 3'b101; d = 3'b011; e = 3'b100; // Set input values
        #period;
        if (!(q === 3'b1111)) begin
            $display("Mismatch at index 6: Inputs = ["3'b001" "3'b010" "3'b101" "3'b011" "3'b100"], Generated = ['q'], Reference = ["3'b1111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 3'b001, 3'b010, 3'b110, 3'b011, 3'b100, Generated = q, Reference = 3'b1111
        a = 3'b001; b = 3'b010; c = 3'b110; d = 3'b011; e = 3'b100; // Set input values
        #period;
        if (!(q === 3'b1111)) begin
            $display("Mismatch at index 7: Inputs = ["3'b001" "3'b010" "3'b110" "3'b011" "3'b100"], Generated = ['q'], Reference = ["3'b1111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 3'b001, 3'b010, 3'b111, 3'b011, 3'b100, Generated = q, Reference = 3'b1111
        a = 3'b001; b = 3'b010; c = 3'b111; d = 3'b011; e = 3'b100; // Set input values
        #period;
        if (!(q === 3'b1111)) begin
            $display("Mismatch at index 8: Inputs = ["3'b001" "3'b010" "3'b111" "3'b011" "3'b100"], Generated = ['q'], Reference = ["3'b1111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 3'b001, 3'b010, 3'b1000, 3'b011, 3'b100, Generated = q, Reference = 3'b1111
        a = 3'b001; b = 3'b010; c = 3'b1000; d = 3'b011; e = 3'b100; // Set input values
        #period;
        if (!(q === 3'b1111)) begin
            $display("Mismatch at index 9: Inputs = ["3'b001" "3'b010" "3'b1000" "3'b011" "3'b100"], Generated = ['q'], Reference = ["3'b1111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 3'b001, 3'b010, 3'b1000, 3'b011, 3'b100, Generated = q, Reference = 3'b1111
        a = 3'b001; b = 3'b010; c = 3'b1000; d = 3'b011; e = 3'b100; // Set input values
        #period;
        if (!(q === 3'b1111)) begin
            $display("Mismatch at index 10: Inputs = ["3'b001" "3'b010" "3'b1000" "3'b011" "3'b100"], Generated = ['q'], Reference = ["3'b1111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 3'b101, 3'b110, 3'b000, 3'b111, 3'b1000, Generated = q, Reference = 3'b110
        a = 3'b101; b = 3'b110; c = 3'b000; d = 3'b111; e = 3'b1000; // Set input values
        #period;
        if (!(q === 3'b110)) begin
            $display("Mismatch at index 11: Inputs = ["3'b101" "3'b110" "3'b000" "3'b111" "3'b1000"], Generated = ['q'], Reference = ["3'b110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 3'b101, 3'b110, 3'b001, 3'b111, 3'b1000, Generated = q, Reference = 3'b1000
        a = 3'b101; b = 3'b110; c = 3'b001; d = 3'b111; e = 3'b1000; // Set input values
        #period;
        if (!(q === 3'b1000)) begin
            $display("Mismatch at index 12: Inputs = ["3'b101" "3'b110" "3'b001" "3'b111" "3'b1000"], Generated = ['q'], Reference = ["3'b1000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 3'b101, 3'b110, 3'b010, 3'b111, 3'b1000, Generated = q, Reference = 3'b101
        a = 3'b101; b = 3'b110; c = 3'b010; d = 3'b111; e = 3'b1000; // Set input values
        #period;
        if (!(q === 3'b101)) begin
            $display("Mismatch at index 13: Inputs = ["3'b101" "3'b110" "3'b010" "3'b111" "3'b1000"], Generated = ['q'], Reference = ["3'b101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 3'b101, 3'b110, 3'b011, 3'b111, 3'b1000, Generated = q, Reference = 3'b111
        a = 3'b101; b = 3'b110; c = 3'b011; d = 3'b111; e = 3'b1000; // Set input values
        #period;
        if (!(q === 3'b111)) begin
            $display("Mismatch at index 14: Inputs = ["3'b101" "3'b110" "3'b011" "3'b111" "3'b1000"], Generated = ['q'], Reference = ["3'b111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 3'b101, 3'b110, 3'b100, 3'b111, 3'b1000, Generated = q, Reference = 3'b1111
        a = 3'b101; b = 3'b110; c = 3'b100; d = 3'b111; e = 3'b1000; // Set input values
        #period;
        if (!(q === 3'b1111)) begin
            $display("Mismatch at index 15: Inputs = ["3'b101" "3'b110" "3'b100" "3'b111" "3'b1000"], Generated = ['q'], Reference = ["3'b1111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 3'b101, 3'b110, 3'b101, 3'b111, 3'b1000, Generated = q, Reference = 3'b1111
        a = 3'b101; b = 3'b110; c = 3'b101; d = 3'b111; e = 3'b1000; // Set input values
        #period;
        if (!(q === 3'b1111)) begin
            $display("Mismatch at index 16: Inputs = ["3'b101" "3'b110" "3'b101" "3'b111" "3'b1000"], Generated = ['q'], Reference = ["3'b1111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 3'b101, 3'b110, 3'b110, 3'b111, 3'b1000, Generated = q, Reference = 3'b1111
        a = 3'b101; b = 3'b110; c = 3'b110; d = 3'b111; e = 3'b1000; // Set input values
        #period;
        if (!(q === 3'b1111)) begin
            $display("Mismatch at index 17: Inputs = ["3'b101" "3'b110" "3'b110" "3'b111" "3'b1000"], Generated = ['q'], Reference = ["3'b1111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 3'b101, 3'b110, 3'b111, 3'b111, 3'b1000, Generated = q, Reference = 3'b1111
        a = 3'b101; b = 3'b110; c = 3'b111; d = 3'b111; e = 3'b1000; // Set input values
        #period;
        if (!(q === 3'b1111)) begin
            $display("Mismatch at index 18: Inputs = ["3'b101" "3'b110" "3'b111" "3'b111" "3'b1000"], Generated = ['q'], Reference = ["3'b1111"]");
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