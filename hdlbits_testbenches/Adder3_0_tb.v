module top_module_tb;

    reg [1:0] a;
    reg b;
    reg cin;

    wire [1:0] cout;
    wire [1:0] sum;


    top_module UUT (.a(a), .b(b), .cin(cin), .cout(cout), .sum(sum));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 2'b10, 4'b0011, 4'b0000, Generated = cout, sum, Reference = 2'b10, 2'b101
        a = 2'b10; b = 4'b0011; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 2'b10 && sum === 2'b101)) begin
            $display("Mismatch at index 0: Inputs = ["2'b10" "4'b0011" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["2'b10", "2'b101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 2'b10, 4'b0011, 4'b0000, Generated = cout, sum, Reference = 2'b10, 2'b101
        a = 2'b10; b = 4'b0011; cin = 4'b0000; // Set input values
        #period;
        if (!(cout === 2'b10 && sum === 2'b101)) begin
            $display("Mismatch at index 1: Inputs = ["2'b10" "4'b0011" "4'b0000"], Generated = ['cout', 'sum'], Reference = ["2'b10", "2'b101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 2'b10, 4'b0011, 4'b0001, Generated = cout, sum, Reference = 2'b11, 2'b110
        a = 2'b10; b = 4'b0011; cin = 4'b0001; // Set input values
        #period;
        if (!(cout === 2'b11 && sum === 2'b110)) begin
            $display("Mismatch at index 2: Inputs = ["2'b10" "4'b0011" "4'b0001"], Generated = ['cout', 'sum'], Reference = ["2'b11", "2'b110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 2'b10, 4'b0011, 4'b0001, Generated = cout, sum, Reference = 2'b11, 2'b110
        a = 2'b10; b = 4'b0011; cin = 4'b0001; // Set input values
        #period;
        if (!(cout === 2'b11 && sum === 2'b110)) begin
            $display("Mismatch at index 3: Inputs = ["2'b10" "4'b0011" "4'b0001"], Generated = ['cout', 'sum'], Reference = ["2'b11", "2'b110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 4);
        $finish;
    end

endmodule