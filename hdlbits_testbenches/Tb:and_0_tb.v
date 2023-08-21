module top_module_tb;


    wire andgate.in;
    wire andgate.out;


    top_module UUT (.andgate.in(andgate.in), .andgate.out(andgate.out));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = , Generated = andgate.in, andgate.out, Reference = 4'b0000, 4'b0000
        ; // Set input values
        #period;
        if (!(andgate.in === 4'b0000 && andgate.out === 4'b0000)) begin
            $display("Mismatch at index 0: Inputs = [], Generated = ['andgate.in', 'andgate.out'], Reference = ["4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = , Generated = andgate.in, andgate.out, Reference = 4'b0001, 4'b0000
        ; // Set input values
        #period;
        if (!(andgate.in === 4'b0001 && andgate.out === 4'b0000)) begin
            $display("Mismatch at index 1: Inputs = [], Generated = ['andgate.in', 'andgate.out'], Reference = ["4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = , Generated = andgate.in, andgate.out, Reference = 4'b0010, 4'b0000
        ; // Set input values
        #period;
        if (!(andgate.in === 4'b0010 && andgate.out === 4'b0000)) begin
            $display("Mismatch at index 2: Inputs = [], Generated = ['andgate.in', 'andgate.out'], Reference = ["4'b0010", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = , Generated = andgate.in, andgate.out, Reference = 4'b0011, 4'b0001
        ; // Set input values
        #period;
        if (!(andgate.in === 4'b0011 && andgate.out === 4'b0001)) begin
            $display("Mismatch at index 3: Inputs = [], Generated = ['andgate.in', 'andgate.out'], Reference = ["4'b0011", "4'b0001"]");
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