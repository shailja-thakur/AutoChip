module top_module_tb;

    reg [1:0] a;
    reg [1:0] b;

    wire [1:0] out_or_bitwise;
    wire out_or_logical;
    wire [4:0] out_not;


    top_module UUT (.a(a), .b(b), .out_or_bitwise(out_or_bitwise), .out_or_logical(out_or_logical), .out_not(out_not));

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = 2'b00, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b00, 4'b0000, 5'b111111
        a = 2'b00; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b00 && out_or_logical === 4'b0000 && out_not === 5'b111111)) begin
            $display("Mismatch at index 0: Inputs = ["2'b00" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b00", "4'b0000", "5'b111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 2'b00, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00111
        a = 2'b00; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00111)) begin
            $display("Mismatch at index 1: Inputs = ["2'b00" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 2'b00, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00111
        a = 2'b00; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00111)) begin
            $display("Mismatch at index 2: Inputs = ["2'b00" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 2'b01, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00110
        a = 2'b01; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00110)) begin
            $display("Mismatch at index 3: Inputs = ["2'b01" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 2'b01, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00110
        a = 2'b01; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00110)) begin
            $display("Mismatch at index 4: Inputs = ["2'b01" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 2'b10, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00101
        a = 2'b10; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00101)) begin
            $display("Mismatch at index 5: Inputs = ["2'b10" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 2'b10, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00101
        a = 2'b10; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00101)) begin
            $display("Mismatch at index 6: Inputs = ["2'b10" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 2'b11, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00100
        a = 2'b11; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00100)) begin
            $display("Mismatch at index 7: Inputs = ["2'b11" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 2'b11, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00100
        a = 2'b11; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00100)) begin
            $display("Mismatch at index 8: Inputs = ["2'b11" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 2'b100, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00011
        a = 2'b100; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00011)) begin
            $display("Mismatch at index 9: Inputs = ["2'b100" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 2'b100, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00011
        a = 2'b100; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00011)) begin
            $display("Mismatch at index 10: Inputs = ["2'b100" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 2'b101, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00010
        a = 2'b101; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00010)) begin
            $display("Mismatch at index 11: Inputs = ["2'b101" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 2'b101, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00010
        a = 2'b101; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00010)) begin
            $display("Mismatch at index 12: Inputs = ["2'b101" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 2'b110, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00001
        a = 2'b110; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00001)) begin
            $display("Mismatch at index 13: Inputs = ["2'b110" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 2'b110, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00001
        a = 2'b110; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00001)) begin
            $display("Mismatch at index 14: Inputs = ["2'b110" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 2'b111, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00000
        a = 2'b111; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00000)) begin
            $display("Mismatch at index 15: Inputs = ["2'b111" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 2'b111, 2'b111, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b00000
        a = 2'b111; b = 2'b111; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b00000)) begin
            $display("Mismatch at index 16: Inputs = ["2'b111" "2'b111"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b00000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 2'b00, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b00, 4'b0000, 5'b111111
        a = 2'b00; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b00 && out_or_logical === 4'b0000 && out_not === 5'b111111)) begin
            $display("Mismatch at index 17: Inputs = ["2'b00" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b00", "4'b0000", "5'b111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 2'b00, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b00, 4'b0000, 5'b111111
        a = 2'b00; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b00 && out_or_logical === 4'b0000 && out_not === 5'b111111)) begin
            $display("Mismatch at index 18: Inputs = ["2'b00" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b00", "4'b0000", "5'b111111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = 2'b01, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b01, 4'b0001, 5'b111110
        a = 2'b01; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b01 && out_or_logical === 4'b0001 && out_not === 5'b111110)) begin
            $display("Mismatch at index 19: Inputs = ["2'b01" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b01", "4'b0001", "5'b111110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = 2'b01, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b01, 4'b0001, 5'b111110
        a = 2'b01; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b01 && out_or_logical === 4'b0001 && out_not === 5'b111110)) begin
            $display("Mismatch at index 20: Inputs = ["2'b01" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b01", "4'b0001", "5'b111110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = 2'b10, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b10, 4'b0001, 5'b111101
        a = 2'b10; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b10 && out_or_logical === 4'b0001 && out_not === 5'b111101)) begin
            $display("Mismatch at index 21: Inputs = ["2'b10" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b10", "4'b0001", "5'b111101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 21 passed!");
        end

        // Tick 22: Inputs = 2'b10, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b10, 4'b0001, 5'b111101
        a = 2'b10; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b10 && out_or_logical === 4'b0001 && out_not === 5'b111101)) begin
            $display("Mismatch at index 22: Inputs = ["2'b10" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b10", "4'b0001", "5'b111101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 22 passed!");
        end

        // Tick 23: Inputs = 2'b11, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b11, 4'b0001, 5'b111100
        a = 2'b11; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b11 && out_or_logical === 4'b0001 && out_not === 5'b111100)) begin
            $display("Mismatch at index 23: Inputs = ["2'b11" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b11", "4'b0001", "5'b111100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 23 passed!");
        end

        // Tick 24: Inputs = 2'b11, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b11, 4'b0001, 5'b111100
        a = 2'b11; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b11 && out_or_logical === 4'b0001 && out_not === 5'b111100)) begin
            $display("Mismatch at index 24: Inputs = ["2'b11" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b11", "4'b0001", "5'b111100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 24 passed!");
        end

        // Tick 25: Inputs = 2'b100, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b100, 4'b0001, 5'b111011
        a = 2'b100; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b100 && out_or_logical === 4'b0001 && out_not === 5'b111011)) begin
            $display("Mismatch at index 25: Inputs = ["2'b100" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b100", "4'b0001", "5'b111011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 25 passed!");
        end

        // Tick 26: Inputs = 2'b100, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b100, 4'b0001, 5'b111011
        a = 2'b100; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b100 && out_or_logical === 4'b0001 && out_not === 5'b111011)) begin
            $display("Mismatch at index 26: Inputs = ["2'b100" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b100", "4'b0001", "5'b111011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 26 passed!");
        end

        // Tick 27: Inputs = 2'b101, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b101, 4'b0001, 5'b111010
        a = 2'b101; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b101 && out_or_logical === 4'b0001 && out_not === 5'b111010)) begin
            $display("Mismatch at index 27: Inputs = ["2'b101" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b101", "4'b0001", "5'b111010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 27 passed!");
        end

        // Tick 28: Inputs = 2'b101, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b101, 4'b0001, 5'b111010
        a = 2'b101; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b101 && out_or_logical === 4'b0001 && out_not === 5'b111010)) begin
            $display("Mismatch at index 28: Inputs = ["2'b101" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b101", "4'b0001", "5'b111010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 28 passed!");
        end

        // Tick 29: Inputs = 2'b110, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b110, 4'b0001, 5'b111001
        a = 2'b110; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b110 && out_or_logical === 4'b0001 && out_not === 5'b111001)) begin
            $display("Mismatch at index 29: Inputs = ["2'b110" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b110", "4'b0001", "5'b111001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 29 passed!");
        end

        // Tick 30: Inputs = 2'b110, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b110, 4'b0001, 5'b111001
        a = 2'b110; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b110 && out_or_logical === 4'b0001 && out_not === 5'b111001)) begin
            $display("Mismatch at index 30: Inputs = ["2'b110" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b110", "4'b0001", "5'b111001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 30 passed!");
        end

        // Tick 31: Inputs = 2'b111, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b111000
        a = 2'b111; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b111000)) begin
            $display("Mismatch at index 31: Inputs = ["2'b111" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b111000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 31 passed!");
        end

        // Tick 32: Inputs = 2'b111, 2'b00, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b111000
        a = 2'b111; b = 2'b00; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b111000)) begin
            $display("Mismatch at index 32: Inputs = ["2'b111" "2'b00"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b111000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 32 passed!");
        end

        // Tick 33: Inputs = 2'b00, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b01, 4'b0001, 5'b110111
        a = 2'b00; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b01 && out_or_logical === 4'b0001 && out_not === 5'b110111)) begin
            $display("Mismatch at index 33: Inputs = ["2'b00" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b01", "4'b0001", "5'b110111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 33 passed!");
        end

        // Tick 34: Inputs = 2'b00, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b01, 4'b0001, 5'b110111
        a = 2'b00; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b01 && out_or_logical === 4'b0001 && out_not === 5'b110111)) begin
            $display("Mismatch at index 34: Inputs = ["2'b00" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b01", "4'b0001", "5'b110111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 34 passed!");
        end

        // Tick 35: Inputs = 2'b01, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b01, 4'b0001, 5'b110110
        a = 2'b01; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b01 && out_or_logical === 4'b0001 && out_not === 5'b110110)) begin
            $display("Mismatch at index 35: Inputs = ["2'b01" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b01", "4'b0001", "5'b110110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 35 passed!");
        end

        // Tick 36: Inputs = 2'b01, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b01, 4'b0001, 5'b110110
        a = 2'b01; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b01 && out_or_logical === 4'b0001 && out_not === 5'b110110)) begin
            $display("Mismatch at index 36: Inputs = ["2'b01" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b01", "4'b0001", "5'b110110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 36 passed!");
        end

        // Tick 37: Inputs = 2'b10, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b11, 4'b0001, 5'b110101
        a = 2'b10; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b11 && out_or_logical === 4'b0001 && out_not === 5'b110101)) begin
            $display("Mismatch at index 37: Inputs = ["2'b10" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b11", "4'b0001", "5'b110101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 37 passed!");
        end

        // Tick 38: Inputs = 2'b10, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b11, 4'b0001, 5'b110101
        a = 2'b10; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b11 && out_or_logical === 4'b0001 && out_not === 5'b110101)) begin
            $display("Mismatch at index 38: Inputs = ["2'b10" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b11", "4'b0001", "5'b110101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 38 passed!");
        end

        // Tick 39: Inputs = 2'b11, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b11, 4'b0001, 5'b110100
        a = 2'b11; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b11 && out_or_logical === 4'b0001 && out_not === 5'b110100)) begin
            $display("Mismatch at index 39: Inputs = ["2'b11" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b11", "4'b0001", "5'b110100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 39 passed!");
        end

        // Tick 40: Inputs = 2'b11, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b11, 4'b0001, 5'b110100
        a = 2'b11; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b11 && out_or_logical === 4'b0001 && out_not === 5'b110100)) begin
            $display("Mismatch at index 40: Inputs = ["2'b11" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b11", "4'b0001", "5'b110100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 40 passed!");
        end

        // Tick 41: Inputs = 2'b100, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b101, 4'b0001, 5'b110011
        a = 2'b100; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b101 && out_or_logical === 4'b0001 && out_not === 5'b110011)) begin
            $display("Mismatch at index 41: Inputs = ["2'b100" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b101", "4'b0001", "5'b110011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 41 passed!");
        end

        // Tick 42: Inputs = 2'b100, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b101, 4'b0001, 5'b110011
        a = 2'b100; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b101 && out_or_logical === 4'b0001 && out_not === 5'b110011)) begin
            $display("Mismatch at index 42: Inputs = ["2'b100" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b101", "4'b0001", "5'b110011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 42 passed!");
        end

        // Tick 43: Inputs = 2'b101, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b101, 4'b0001, 5'b110010
        a = 2'b101; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b101 && out_or_logical === 4'b0001 && out_not === 5'b110010)) begin
            $display("Mismatch at index 43: Inputs = ["2'b101" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b101", "4'b0001", "5'b110010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 43 passed!");
        end

        // Tick 44: Inputs = 2'b101, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b101, 4'b0001, 5'b110010
        a = 2'b101; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b101 && out_or_logical === 4'b0001 && out_not === 5'b110010)) begin
            $display("Mismatch at index 44: Inputs = ["2'b101" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b101", "4'b0001", "5'b110010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 44 passed!");
        end

        // Tick 45: Inputs = 2'b110, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b110001
        a = 2'b110; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b110001)) begin
            $display("Mismatch at index 45: Inputs = ["2'b110" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b110001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 45 passed!");
        end

        // Tick 46: Inputs = 2'b110, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b110001
        a = 2'b110; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b110001)) begin
            $display("Mismatch at index 46: Inputs = ["2'b110" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b110001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 46 passed!");
        end

        // Tick 47: Inputs = 2'b111, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b110000
        a = 2'b111; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b110000)) begin
            $display("Mismatch at index 47: Inputs = ["2'b111" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b110000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 47 passed!");
        end

        // Tick 48: Inputs = 2'b111, 2'b01, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b111, 4'b0001, 5'b110000
        a = 2'b111; b = 2'b01; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b111 && out_or_logical === 4'b0001 && out_not === 5'b110000)) begin
            $display("Mismatch at index 48: Inputs = ["2'b111" "2'b01"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b111", "4'b0001", "5'b110000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 48 passed!");
        end

        // Tick 49: Inputs = 2'b00, 2'b10, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b10, 4'b0001, 5'b101111
        a = 2'b00; b = 2'b10; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b10 && out_or_logical === 4'b0001 && out_not === 5'b101111)) begin
            $display("Mismatch at index 49: Inputs = ["2'b00" "2'b10"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b10", "4'b0001", "5'b101111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 49 passed!");
        end

        // Tick 50: Inputs = 2'b00, 2'b10, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b10, 4'b0001, 5'b101111
        a = 2'b00; b = 2'b10; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b10 && out_or_logical === 4'b0001 && out_not === 5'b101111)) begin
            $display("Mismatch at index 50: Inputs = ["2'b00" "2'b10"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b10", "4'b0001", "5'b101111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 50 passed!");
        end

        // Tick 51: Inputs = 2'b01, 2'b10, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b11, 4'b0001, 5'b101110
        a = 2'b01; b = 2'b10; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b11 && out_or_logical === 4'b0001 && out_not === 5'b101110)) begin
            $display("Mismatch at index 51: Inputs = ["2'b01" "2'b10"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b11", "4'b0001", "5'b101110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 51 passed!");
        end

        // Tick 52: Inputs = 2'b01, 2'b10, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b11, 4'b0001, 5'b101110
        a = 2'b01; b = 2'b10; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b11 && out_or_logical === 4'b0001 && out_not === 5'b101110)) begin
            $display("Mismatch at index 52: Inputs = ["2'b01" "2'b10"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b11", "4'b0001", "5'b101110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 52 passed!");
        end

        // Tick 53: Inputs = 2'b10, 2'b10, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b10, 4'b0001, 5'b101101
        a = 2'b10; b = 2'b10; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b10 && out_or_logical === 4'b0001 && out_not === 5'b101101)) begin
            $display("Mismatch at index 53: Inputs = ["2'b10" "2'b10"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b10", "4'b0001", "5'b101101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 53 passed!");
        end

        // Tick 54: Inputs = 2'b10, 2'b10, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b10, 4'b0001, 5'b101101
        a = 2'b10; b = 2'b10; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b10 && out_or_logical === 4'b0001 && out_not === 5'b101101)) begin
            $display("Mismatch at index 54: Inputs = ["2'b10" "2'b10"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b10", "4'b0001", "5'b101101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 54 passed!");
        end

        // Tick 55: Inputs = 2'b11, 2'b10, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b11, 4'b0001, 5'b101100
        a = 2'b11; b = 2'b10; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b11 && out_or_logical === 4'b0001 && out_not === 5'b101100)) begin
            $display("Mismatch at index 55: Inputs = ["2'b11" "2'b10"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b11", "4'b0001", "5'b101100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 55 passed!");
        end

        // Tick 56: Inputs = 2'b11, 2'b10, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b11, 4'b0001, 5'b101100
        a = 2'b11; b = 2'b10; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b11 && out_or_logical === 4'b0001 && out_not === 5'b101100)) begin
            $display("Mismatch at index 56: Inputs = ["2'b11" "2'b10"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b11", "4'b0001", "5'b101100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 56 passed!");
        end

        // Tick 57: Inputs = 2'b100, 2'b10, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b110, 4'b0001, 5'b101011
        a = 2'b100; b = 2'b10; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b110 && out_or_logical === 4'b0001 && out_not === 5'b101011)) begin
            $display("Mismatch at index 57: Inputs = ["2'b100" "2'b10"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b110", "4'b0001", "5'b101011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 57 passed!");
        end

        // Tick 58: Inputs = 2'b100, 2'b10, Generated = out_or_bitwise, out_or_logical, out_not, Reference = 2'b110, 4'b0001, 5'b101011
        a = 2'b100; b = 2'b10; // Set input values
        #period;
        if (!(out_or_bitwise === 2'b110 && out_or_logical === 4'b0001 && out_not === 5'b101011)) begin
            $display("Mismatch at index 58: Inputs = ["2'b100" "2'b10"], Generated = ['out_or_bitwise', 'out_or_logical', 'out_not'], Reference = ["2'b110", "4'b0001", "5'b101011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 58 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 59);
        $finish;
    end

endmodule