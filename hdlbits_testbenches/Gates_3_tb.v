module top_module_tb;

    reg a;
    reg b;

    wire out_and;
    wire out_or;
    wire out_xor;
    wire out_nand;
    wire out_nor;
    wire out_xnor;
    wire out_anotb;


    top_module UUT (.a(a), .b(b), .out_and(out_and), .out_or(out_or), .out_xor(out_xor), .out_nand(out_nand), .out_nor(out_nor), .out_xnor(out_xnor), .out_anotb(out_anotb));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 4'b0000, 4'b0000, Generated = out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0001, 4'b0001, 4'b0001, 4'b0000
        a = 4'b0000; b = 4'b0000; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0000 && out_xor === 4'b0000 && out_nand === 4'b0001 && out_nor === 4'b0001 && out_xnor === 4'b0001 && out_anotb === 4'b0000)) begin
            $display("Mismatch at index 0: Inputs = ["4'b0000" "4'b0000"], Generated = ['out_and', 'out_or', 'out_xor', 'out_nand', 'out_nor', 'out_xnor', 'out_anotb'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0001", "4'b0001", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 4'b0000, 4'b0000, Generated = out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0001, 4'b0001, 4'b0001, 4'b0000
        a = 4'b0000; b = 4'b0000; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0000 && out_xor === 4'b0000 && out_nand === 4'b0001 && out_nor === 4'b0001 && out_xnor === 4'b0001 && out_anotb === 4'b0000)) begin
            $display("Mismatch at index 1: Inputs = ["4'b0000" "4'b0000"], Generated = ['out_and', 'out_or', 'out_xor', 'out_nand', 'out_nor', 'out_xnor', 'out_anotb'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0001", "4'b0001", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 4'b0000, 4'b0000, Generated = out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0001, 4'b0001, 4'b0001, 4'b0000
        a = 4'b0000; b = 4'b0000; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0000 && out_xor === 4'b0000 && out_nand === 4'b0001 && out_nor === 4'b0001 && out_xnor === 4'b0001 && out_anotb === 4'b0000)) begin
            $display("Mismatch at index 2: Inputs = ["4'b0000" "4'b0000"], Generated = ['out_and', 'out_or', 'out_xor', 'out_nand', 'out_nor', 'out_xnor', 'out_anotb'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0001", "4'b0001", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 4'b0000, 4'b0001, Generated = out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb, Reference = 4'b0000, 4'b0001, 4'b0001, 4'b0001, 4'b0000, 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0001 && out_xor === 4'b0001 && out_nand === 4'b0001 && out_nor === 4'b0000 && out_xnor === 4'b0000 && out_anotb === 4'b0000)) begin
            $display("Mismatch at index 3: Inputs = ["4'b0000" "4'b0001"], Generated = ['out_and', 'out_or', 'out_xor', 'out_nand', 'out_nor', 'out_xnor', 'out_anotb'], Reference = ["4'b0000", "4'b0001", "4'b0001", "4'b0001", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 4'b0000, 4'b0001, Generated = out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb, Reference = 4'b0000, 4'b0001, 4'b0001, 4'b0001, 4'b0000, 4'b0000, 4'b0000
        a = 4'b0000; b = 4'b0001; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0001 && out_xor === 4'b0001 && out_nand === 4'b0001 && out_nor === 4'b0000 && out_xnor === 4'b0000 && out_anotb === 4'b0000)) begin
            $display("Mismatch at index 4: Inputs = ["4'b0000" "4'b0001"], Generated = ['out_and', 'out_or', 'out_xor', 'out_nand', 'out_nor', 'out_xnor', 'out_anotb'], Reference = ["4'b0000", "4'b0001", "4'b0001", "4'b0001", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 4'b0001, 4'b0000, Generated = out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb, Reference = 4'b0000, 4'b0001, 4'b0001, 4'b0001, 4'b0000, 4'b0000, 4'b0001
        a = 4'b0001; b = 4'b0000; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0001 && out_xor === 4'b0001 && out_nand === 4'b0001 && out_nor === 4'b0000 && out_xnor === 4'b0000 && out_anotb === 4'b0001)) begin
            $display("Mismatch at index 5: Inputs = ["4'b0001" "4'b0000"], Generated = ['out_and', 'out_or', 'out_xor', 'out_nand', 'out_nor', 'out_xnor', 'out_anotb'], Reference = ["4'b0000", "4'b0001", "4'b0001", "4'b0001", "4'b0000", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 4'b0001, 4'b0000, Generated = out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb, Reference = 4'b0000, 4'b0001, 4'b0001, 4'b0001, 4'b0000, 4'b0000, 4'b0001
        a = 4'b0001; b = 4'b0000; // Set input values
        #period;
        if (!(out_and === 4'b0000 && out_or === 4'b0001 && out_xor === 4'b0001 && out_nand === 4'b0001 && out_nor === 4'b0000 && out_xnor === 4'b0000 && out_anotb === 4'b0001)) begin
            $display("Mismatch at index 6: Inputs = ["4'b0001" "4'b0000"], Generated = ['out_and', 'out_or', 'out_xor', 'out_nand', 'out_nor', 'out_xnor', 'out_anotb'], Reference = ["4'b0000", "4'b0001", "4'b0001", "4'b0001", "4'b0000", "4'b0000", "4'b0001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 4'b0001, 4'b0001, Generated = out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb, Reference = 4'b0001, 4'b0001, 4'b0000, 4'b0000, 4'b0000, 4'b0001, 4'b0000
        a = 4'b0001; b = 4'b0001; // Set input values
        #period;
        if (!(out_and === 4'b0001 && out_or === 4'b0001 && out_xor === 4'b0000 && out_nand === 4'b0000 && out_nor === 4'b0000 && out_xnor === 4'b0001 && out_anotb === 4'b0000)) begin
            $display("Mismatch at index 7: Inputs = ["4'b0001" "4'b0001"], Generated = ['out_and', 'out_or', 'out_xor', 'out_nand', 'out_nor', 'out_xnor', 'out_anotb'], Reference = ["4'b0001", "4'b0001", "4'b0000", "4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 8);
        $finish;
    end

endmodule