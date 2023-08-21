module top_module_tb;

    reg [98:0] in;

    wire out_and;
    wire out_or;
    wire out_xor;


    top_module UUT (.in(in), .out_and(out_and), .out_or(out_or), .out_xor(out_xor));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, Generated = out_and, out_or, out_xor, Reference = 4'b0000, 4'b0000, 4'b0000
        in = 99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0000 && out_xor === 4'b0000)) begin
            $display("Mismatch at index 0: Inputs = ["99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"], Generated = ['out_and', 'out_or', 'out_xor'], Reference = ["4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, Generated = out_and, out_or, out_xor, Reference = 4'b0000, 4'b0000, 4'b0000
        in = 99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0000 && out_xor === 4'b0000)) begin
            $display("Mismatch at index 1: Inputs = ["99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"], Generated = ['out_and', 'out_or', 'out_xor'], Reference = ["4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 99'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111, Generated = out_and, out_or, out_xor, Reference = 4'b0001, 4'b0001, 4'b0000
        in = 99'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111; // Set input values
        #period;
        if (!(out_and === 4'b0001 && out_or === 4'b0001 && out_xor === 4'b0000)) begin
            $display("Mismatch at index 2: Inputs = ["99'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"], Generated = ['out_and', 'out_or', 'out_xor'], Reference = ["4'b0001", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111, Generated = out_and, out_or, out_xor, Reference = 4'b0000, 4'b0001, 4'b0000
        in = 99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0001 && out_xor === 4'b0000)) begin
            $display("Mismatch at index 3: Inputs = ["99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111"], Generated = ['out_and', 'out_or', 'out_xor'], Reference = ["4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 99'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111000000000000000000, Generated = out_and, out_or, out_xor, Reference = 4'b0000, 4'b0001, 4'b0000
        in = 99'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111000000000000000000; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0001 && out_xor === 4'b0000)) begin
            $display("Mismatch at index 4: Inputs = ["99'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111000000000000000000"], Generated = ['out_and', 'out_or', 'out_xor'], Reference = ["4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000, Generated = out_and, out_or, out_xor, Reference = 4'b0000, 4'b0001, 4'b0001
        in = 99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0001 && out_xor === 4'b0001)) begin
            $display("Mismatch at index 5: Inputs = ["99'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000"], Generated = ['out_and', 'out_or', 'out_xor'], Reference = ["4'b0000", "4'b0001", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 6);
        $finish;
    end

endmodule