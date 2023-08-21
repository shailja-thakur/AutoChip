module top_module_tb;

    reg [14:0] a;
    reg b;
    reg cin;

    wire cout;
    wire [14:0] sum;


    top_module UUT (.a(a), .b(b), .cin(cin), .cout(cout), .sum(sum));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 15'b000000000000000, 16'b0000000000000000, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b000000000000000
        a = 15'b000000000000000; b = 16'b0000000000000000; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000000000000)) begin
            $display("Mismatch at index 0: Inputs = ["15'b000000000000000" "16'b0000000000000000" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 15'b000000000000001, 16'b0000000000000001, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b000000000000010
        a = 15'b000000000000001; b = 16'b0000000000000001; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000000000010)) begin
            $display("Mismatch at index 1: Inputs = ["15'b000000000000001" "16'b0000000000000001" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000000000010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 15'b000000000000001, 16'b0000000000000001, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b000000000000010
        a = 15'b000000000000001; b = 16'b0000000000000001; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000000000010)) begin
            $display("Mismatch at index 2: Inputs = ["15'b000000000000001" "16'b0000000000000001" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000000000010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 15'b001000100010001, 16'b0010001000100010, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b011001100110011
        a = 15'b001000100010001; b = 16'b0010001000100010; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b011001100110011)) begin
            $display("Mismatch at index 3: Inputs = ["15'b001000100010001" "16'b0010001000100010" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b011001100110011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 15'b001000100010001, 16'b0010001000100010, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b011001100110011
        a = 15'b001000100010001; b = 16'b0010001000100010; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b011001100110011)) begin
            $display("Mismatch at index 4: Inputs = ["15'b001000100010001" "16'b0010001000100010" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b011001100110011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 15'b000000000000101, 16'b0000000000000101, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b000000000010000
        a = 15'b000000000000101; b = 16'b0000000000000101; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000000010000)) begin
            $display("Mismatch at index 5: Inputs = ["15'b000000000000101" "16'b0000000000000101" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000000010000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 15'b000000000000101, 16'b0000000000000101, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b000000000010000
        a = 15'b000000000000101; b = 16'b0000000000000101; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000000010000)) begin
            $display("Mismatch at index 6: Inputs = ["15'b000000000000101" "16'b0000000000000101" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000000010000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 15'b000000010011001, 16'b0000000000000001, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b000000100000000
        a = 15'b000000010011001; b = 16'b0000000000000001; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000100000000)) begin
            $display("Mismatch at index 7: Inputs = ["15'b000000010011001" "16'b0000000000000001" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000100000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 15'b000000010011001, 16'b0000000000000001, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b000000100000000
        a = 15'b000000010011001; b = 16'b0000000000000001; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000100000000)) begin
            $display("Mismatch at index 8: Inputs = ["15'b000000010011001" "16'b0000000000000001" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000100000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 15'b1001100110011001, 16'b0000000000000001, 4'b0000, Generated = cout, sum, Reference = 4'b0001, 15'b000000000000000
        a = 15'b1001100110011001; b = 16'b0000000000000001; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0001 && sum === 15'b000000000000000)) begin
            $display("Mismatch at index 9: Inputs = ["15'b1001100110011001" "16'b0000000000000001" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0001", "15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 15'b1001100110011001, 16'b0000000000000001, 4'b0000, Generated = cout, sum, Reference = 4'b0001, 15'b000000000000000
        a = 15'b1001100110011001; b = 16'b0000000000000001; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0001 && sum === 15'b000000000000000)) begin
            $display("Mismatch at index 10: Inputs = ["15'b1001100110011001" "16'b0000000000000001" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0001", "15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 15'b000000000000001, 16'b1001100110011001, 4'b0000, Generated = cout, sum, Reference = 4'b0001, 15'b000000000000000
        a = 15'b000000000000001; b = 16'b1001100110011001; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0001 && sum === 15'b000000000000000)) begin
            $display("Mismatch at index 11: Inputs = ["15'b000000000000001" "16'b1001100110011001" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0001", "15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 15'b000000000000001, 16'b1001100110011001, 4'b0000, Generated = cout, sum, Reference = 4'b0001, 15'b000000000000000
        a = 15'b000000000000001; b = 16'b1001100110011001; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0001 && sum === 15'b000000000000000)) begin
            $display("Mismatch at index 12: Inputs = ["15'b000000000000001" "16'b1001100110011001" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0001", "15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 15'b000000010011000, 16'b0000000000000001, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b000000010011001
        a = 15'b000000010011000; b = 16'b0000000000000001; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000010011001)) begin
            $display("Mismatch at index 13: Inputs = ["15'b000000010011000" "16'b0000000000000001" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000010011001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 15'b000000010011000, 16'b0000000000000001, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b000000010011001
        a = 15'b000000010011000; b = 16'b0000000000000001; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000010011001)) begin
            $display("Mismatch at index 14: Inputs = ["15'b000000010011000" "16'b0000000000000001" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000010011001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 15'b000000010011000, 16'b0000000000000001, 4'b0001, Generated = cout, sum, Reference = 4'b0000, 15'b000000100000000
        a = 15'b000000010011000; b = 16'b0000000000000001; cin = 4'b0001; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000100000000)) begin
            $display("Mismatch at index 15: Inputs = ["15'b000000010011000" "16'b0000000000000001" "4'b0001"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000100000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 15'b000000010011000, 16'b0000000000000001, 4'b0001, Generated = cout, sum, Reference = 4'b0000, 15'b000000100000000
        a = 15'b000000010011000; b = 16'b0000000000000001; cin = 4'b0001; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b000000100000000)) begin
            $display("Mismatch at index 16: Inputs = ["15'b000000010011000" "16'b0000000000000001" "4'b0001"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b000000100000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 15'b100010001000100, 16'b0101010101010101, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b1001100110011001
        a = 15'b100010001000100; b = 16'b0101010101010101; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b1001100110011001)) begin
            $display("Mismatch at index 17: Inputs = ["15'b100010001000100" "16'b0101010101010101" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b1001100110011001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 15'b100010001000100, 16'b0101010101010101, 4'b0000, Generated = cout, sum, Reference = 4'b0000, 15'b1001100110011001
        a = 15'b100010001000100; b = 16'b0101010101010101; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 4'b0000 && sum === 15'b1001100110011001)) begin
            $display("Mismatch at index 18: Inputs = ["15'b100010001000100" "16'b0101010101010101" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["4'b0000", "15'b1001100110011001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = 15'b100010001000100, 16'b0101010101010101, 4'b0001, Generated = cout, sum, Reference = 4'b0001, 15'b000000000000000
        a = 15'b100010001000100; b = 16'b0101010101010101; cin = 4'b0001; // Set input values
        #period;
        if (!(cout === 4'b0001 && sum === 15'b000000000000000)) begin
            $display("Mismatch at index 19: Inputs = ["15'b100010001000100" "16'b0101010101010101" "4'b0001"], Generated = ['cout', 'sum'], Reference = ["4'b0001", "15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = 15'b100010001000100, 16'b0101010101010101, 4'b0001, Generated = cout, sum, Reference = 4'b0001, 15'b000000000000000
        a = 15'b100010001000100; b = 16'b0101010101010101; cin = 4'b0001; // Set input values
        #period;
        if (!(cout === 4'b0001 && sum === 15'b000000000000000)) begin
            $display("Mismatch at index 20: Inputs = ["15'b100010001000100" "16'b0101010101010101" "4'b0001"], Generated = ['cout', 'sum'], Reference = ["4'b0001", "15'b000000000000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 20 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 21);
        $finish;
    end

endmodule