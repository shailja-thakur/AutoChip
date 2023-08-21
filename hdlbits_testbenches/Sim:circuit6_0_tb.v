module top_module_tb;

    reg [1:0] a;

    wire [14:0] q;


    top_module UUT (.a(a), .q(q));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = x, Generated = q, Reference = 8'bx
        a = 8'bx; // Set input values
        #period;
        if (!(q === 8'bx)) begin
            $display("Mismatch at index 0: Inputs = ['x'], Generated = ['q'], Reference = ["8'bx"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 2'b00, Generated = q, Reference = 15'b001001000110010
        a = 2'b00; // Set input values
        #period;
        if (!(q === 15'b001001000110010)) begin
            $display("Mismatch at index 1: Inputs = ["2'b00"], Generated = ['q'], Reference = ["15'b001001000110010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 2'b01, Generated = q, Reference = 15'b1010111011100000
        a = 2'b01; // Set input values
        #period;
        if (!(q === 15'b1010111011100000)) begin
            $display("Mismatch at index 2: Inputs = ["2'b01"], Generated = ['q'], Reference = ["15'b1010111011100000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 2'b10, Generated = q, Reference = 15'b010011111010100
        a = 2'b10; // Set input values
        #period;
        if (!(q === 15'b010011111010100)) begin
            $display("Mismatch at index 3: Inputs = ["2'b10"], Generated = ['q'], Reference = ["15'b010011111010100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 2'b11, Generated = q, Reference = 15'b101101000001110
        a = 2'b11; // Set input values
        #period;
        if (!(q === 15'b101101000001110)) begin
            $display("Mismatch at index 4: Inputs = ["2'b11"], Generated = ['q'], Reference = ["15'b101101000001110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 2'b100, Generated = q, Reference = 15'b010000001100110
        a = 2'b100; // Set input values
        #period;
        if (!(q === 15'b010000001100110)) begin
            $display("Mismatch at index 5: Inputs = ["2'b100"], Generated = ['q'], Reference = ["15'b010000001100110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 2'b101, Generated = q, Reference = 15'b110010011001110
        a = 2'b101; // Set input values
        #period;
        if (!(q === 15'b110010011001110)) begin
            $display("Mismatch at index 6: Inputs = ["2'b101"], Generated = ['q'], Reference = ["15'b110010011001110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 2'b110, Generated = q, Reference = 15'b1100010100100110
        a = 2'b110; // Set input values
        #period;
        if (!(q === 15'b1100010100100110)) begin
            $display("Mismatch at index 7: Inputs = ["2'b110"], Generated = ['q'], Reference = ["15'b1100010100100110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 2'b111, Generated = q, Reference = 15'b010111100011001
        a = 2'b111; // Set input values
        #period;
        if (!(q === 15'b010111100011001)) begin
            $display("Mismatch at index 8: Inputs = ["2'b111"], Generated = ['q'], Reference = ["15'b010111100011001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 2'b00, Generated = q, Reference = 15'b001001000110010
        a = 2'b00; // Set input values
        #period;
        if (!(q === 15'b001001000110010)) begin
            $display("Mismatch at index 9: Inputs = ["2'b00"], Generated = ['q'], Reference = ["15'b001001000110010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 2'b01, Generated = q, Reference = 15'b1010111011100000
        a = 2'b01; // Set input values
        #period;
        if (!(q === 15'b1010111011100000)) begin
            $display("Mismatch at index 10: Inputs = ["2'b01"], Generated = ['q'], Reference = ["15'b1010111011100000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 11);
        $finish;
    end

endmodule