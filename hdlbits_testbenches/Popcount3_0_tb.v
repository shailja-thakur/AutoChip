module top_module_tb;

    reg [1:0] in;

    wire [0:0] out;


    top_module UUT (.in(in), .out(out));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 2'b111, Generated = out, Reference = 1'b11
        in = 2'b111; // Set input values
        #period;
        if (!(out === 1'b11)) begin
            $display("Mismatch at index 0: Inputs = ["2'b111"], Generated = ['out'], Reference = ["1'b11"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 2'b00, Generated = out, Reference = 1'b0
        in = 2'b00; // Set input values
        #period;
        if (!(out === 1'b0)) begin
            $display("Mismatch at index 1: Inputs = ["2'b00"], Generated = ['out'], Reference = ["1'b0"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 2'b00, Generated = out, Reference = 1'b0
        in = 2'b00; // Set input values
        #period;
        if (!(out === 1'b0)) begin
            $display("Mismatch at index 2: Inputs = ["2'b00"], Generated = ['out'], Reference = ["1'b0"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 2'b01, Generated = out, Reference = 1'b1
        in = 2'b01; // Set input values
        #period;
        if (!(out === 1'b1)) begin
            $display("Mismatch at index 3: Inputs = ["2'b01"], Generated = ['out'], Reference = ["1'b1"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 2'b01, Generated = out, Reference = 1'b1
        in = 2'b01; // Set input values
        #period;
        if (!(out === 1'b1)) begin
            $display("Mismatch at index 4: Inputs = ["2'b01"], Generated = ['out'], Reference = ["1'b1"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 2'b10, Generated = out, Reference = 1'b1
        in = 2'b10; // Set input values
        #period;
        if (!(out === 1'b1)) begin
            $display("Mismatch at index 5: Inputs = ["2'b10"], Generated = ['out'], Reference = ["1'b1"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 2'b10, Generated = out, Reference = 1'b1
        in = 2'b10; // Set input values
        #period;
        if (!(out === 1'b1)) begin
            $display("Mismatch at index 6: Inputs = ["2'b10"], Generated = ['out'], Reference = ["1'b1"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 2'b11, Generated = out, Reference = 1'b10
        in = 2'b11; // Set input values
        #period;
        if (!(out === 1'b10)) begin
            $display("Mismatch at index 7: Inputs = ["2'b11"], Generated = ['out'], Reference = ["1'b10"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 2'b11, Generated = out, Reference = 1'b10
        in = 2'b11; // Set input values
        #period;
        if (!(out === 1'b10)) begin
            $display("Mismatch at index 8: Inputs = ["2'b11"], Generated = ['out'], Reference = ["1'b10"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 2'b100, Generated = out, Reference = 1'b1
        in = 2'b100; // Set input values
        #period;
        if (!(out === 1'b1)) begin
            $display("Mismatch at index 9: Inputs = ["2'b100"], Generated = ['out'], Reference = ["1'b1"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 2'b100, Generated = out, Reference = 1'b1
        in = 2'b100; // Set input values
        #period;
        if (!(out === 1'b1)) begin
            $display("Mismatch at index 10: Inputs = ["2'b100"], Generated = ['out'], Reference = ["1'b1"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 2'b101, Generated = out, Reference = 1'b10
        in = 2'b101; // Set input values
        #period;
        if (!(out === 1'b10)) begin
            $display("Mismatch at index 11: Inputs = ["2'b101"], Generated = ['out'], Reference = ["1'b10"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 2'b101, Generated = out, Reference = 1'b10
        in = 2'b101; // Set input values
        #period;
        if (!(out === 1'b10)) begin
            $display("Mismatch at index 12: Inputs = ["2'b101"], Generated = ['out'], Reference = ["1'b10"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 2'b110, Generated = out, Reference = 1'b10
        in = 2'b110; // Set input values
        #period;
        if (!(out === 1'b10)) begin
            $display("Mismatch at index 13: Inputs = ["2'b110"], Generated = ['out'], Reference = ["1'b10"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 2'b110, Generated = out, Reference = 1'b10
        in = 2'b110; // Set input values
        #period;
        if (!(out === 1'b10)) begin
            $display("Mismatch at index 14: Inputs = ["2'b110"], Generated = ['out'], Reference = ["1'b10"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 2'b111, Generated = out, Reference = 1'b11
        in = 2'b111; // Set input values
        #period;
        if (!(out === 1'b11)) begin
            $display("Mismatch at index 15: Inputs = ["2'b111"], Generated = ['out'], Reference = ["1'b11"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 2'b111, Generated = out, Reference = 1'b11
        in = 2'b111; // Set input values
        #period;
        if (!(out === 1'b11)) begin
            $display("Mismatch at index 16: Inputs = ["2'b111"], Generated = ['out'], Reference = ["1'b11"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 2'b00, Generated = out, Reference = 1'b0
        in = 2'b00; // Set input values
        #period;
        if (!(out === 1'b0)) begin
            $display("Mismatch at index 17: Inputs = ["2'b00"], Generated = ['out'], Reference = ["1'b0"]");
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