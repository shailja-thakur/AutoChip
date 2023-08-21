module top_module_tb;

    reg clk;
    reg reset;
    reg ena;

    wire pm;
    wire [6:0] hh;
    wire [6:0] mm;
    wire [6:0] ss;


    top_module UUT (.clk(clk), .reset(reset), .ena(ena), .pm(pm), .hh(hh), .mm(mm), .ss(ss));

    initial // clk generation
    begin
        clk = 0;
        forever begin
            #(period/2);
            clk = ~clk;
        end
    end

    initial begin
        integer mismatch_count;
        mismatch_count = 0;

        // Tick 0: Inputs = High, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0000, 7'b0010001, 7'b1011001, 7'b1010101
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0000 && hh === 7'b0010001 && mm === 7'b1011001 && ss === 7'b1010101)) begin
            $display("Mismatch at index 0: Inputs = ['High' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0000", "7'b0010001", "7'b1011001", "7'b1010101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = Low, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0000, 7'b0010001, 7'b1011001, 7'b1010101
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0000 && hh === 7'b0010001 && mm === 7'b1011001 && ss === 7'b1010101)) begin
            $display("Mismatch at index 1: Inputs = ['Low' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0000", "7'b0010001", "7'b1011001", "7'b1010101"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = High, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0000, 7'b0010001, 7'b1011001, 7'b1010110
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0000 && hh === 7'b0010001 && mm === 7'b1011001 && ss === 7'b1010110)) begin
            $display("Mismatch at index 2: Inputs = ['High' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0000", "7'b0010001", "7'b1011001", "7'b1010110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = Low, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0000, 7'b0010001, 7'b1011001, 7'b1010110
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0000 && hh === 7'b0010001 && mm === 7'b1011001 && ss === 7'b1010110)) begin
            $display("Mismatch at index 3: Inputs = ['Low' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0000", "7'b0010001", "7'b1011001", "7'b1010110"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = High, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0000, 7'b0010001, 7'b1011001, 7'b1010111
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0000 && hh === 7'b0010001 && mm === 7'b1011001 && ss === 7'b1010111)) begin
            $display("Mismatch at index 4: Inputs = ['High' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0000", "7'b0010001", "7'b1011001", "7'b1010111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = Low, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0000, 7'b0010001, 7'b1011001, 7'b1010111
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0000 && hh === 7'b0010001 && mm === 7'b1011001 && ss === 7'b1010111)) begin
            $display("Mismatch at index 5: Inputs = ['Low' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0000", "7'b0010001", "7'b1011001", "7'b1010111"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = High, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0000, 7'b0010001, 7'b1011001, 7'b1011000
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0000 && hh === 7'b0010001 && mm === 7'b1011001 && ss === 7'b1011000)) begin
            $display("Mismatch at index 6: Inputs = ['High' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0000", "7'b0010001", "7'b1011001", "7'b1011000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = Low, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0000, 7'b0010001, 7'b1011001, 7'b1011000
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0000 && hh === 7'b0010001 && mm === 7'b1011001 && ss === 7'b1011000)) begin
            $display("Mismatch at index 7: Inputs = ['Low' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0000", "7'b0010001", "7'b1011001", "7'b1011000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = High, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0000, 7'b0010001, 7'b1011001, 7'b1011001
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0000 && hh === 7'b0010001 && mm === 7'b1011001 && ss === 7'b1011001)) begin
            $display("Mismatch at index 8: Inputs = ['High' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0000", "7'b0010001", "7'b1011001", "7'b1011001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = Low, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0000, 7'b0010001, 7'b1011001, 7'b1011001
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0000 && hh === 7'b0010001 && mm === 7'b1011001 && ss === 7'b1011001)) begin
            $display("Mismatch at index 9: Inputs = ['Low' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0000", "7'b0010001", "7'b1011001", "7'b1011001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = High, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0001, 7'b0010010, 7'b0000000, 7'b0000000
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0001 && hh === 7'b0010010 && mm === 7'b0000000 && ss === 7'b0000000)) begin
            $display("Mismatch at index 10: Inputs = ['High' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0001", "7'b0010010", "7'b0000000", "7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = Low, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0001, 7'b0010010, 7'b0000000, 7'b0000000
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0001 && hh === 7'b0010010 && mm === 7'b0000000 && ss === 7'b0000000)) begin
            $display("Mismatch at index 11: Inputs = ['Low' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0001", "7'b0010010", "7'b0000000", "7'b0000000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = High, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0001, 7'b0010010, 7'b0000000, 7'b0000001
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0001 && hh === 7'b0010010 && mm === 7'b0000000 && ss === 7'b0000001)) begin
            $display("Mismatch at index 12: Inputs = ['High' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0001", "7'b0010010", "7'b0000000", "7'b0000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = Low, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0001, 7'b0010010, 7'b0000000, 7'b0000001
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0001 && hh === 7'b0010010 && mm === 7'b0000000 && ss === 7'b0000001)) begin
            $display("Mismatch at index 13: Inputs = ['Low' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0001", "7'b0010010", "7'b0000000", "7'b0000001"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = High, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0001, 7'b0010010, 7'b0000000, 7'b0000010
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0001 && hh === 7'b0010010 && mm === 7'b0000000 && ss === 7'b0000010)) begin
            $display("Mismatch at index 14: Inputs = ['High' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0001", "7'b0010010", "7'b0000000", "7'b0000010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = Low, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0001, 7'b0010010, 7'b0000000, 7'b0000010
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0001 && hh === 7'b0010010 && mm === 7'b0000000 && ss === 7'b0000010)) begin
            $display("Mismatch at index 15: Inputs = ['Low' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0001", "7'b0010010", "7'b0000000", "7'b0000010"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = High, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0001, 7'b0010010, 7'b0000000, 7'b0000011
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0001 && hh === 7'b0010010 && mm === 7'b0000000 && ss === 7'b0000011)) begin
            $display("Mismatch at index 16: Inputs = ['High' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0001", "7'b0010010", "7'b0000000", "7'b0000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = Low, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0001, 7'b0010010, 7'b0000000, 7'b0000011
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0001 && hh === 7'b0010010 && mm === 7'b0000000 && ss === 7'b0000011)) begin
            $display("Mismatch at index 17: Inputs = ['Low' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0001", "7'b0010010", "7'b0000000", "7'b0000011"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = High, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0001, 7'b0010010, 7'b0000000, 7'b0000100
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0001 && hh === 7'b0010010 && mm === 7'b0000000 && ss === 7'b0000100)) begin
            $display("Mismatch at index 18: Inputs = ['High' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0001", "7'b0010010", "7'b0000000", "7'b0000100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = Low, 4'b0000, 4'b0001, Generated = pm, hh, mm, ss, Reference = 4'b0001, 7'b0010010, 7'b0000000, 7'b0000100
        reset = 4'b0000; ena = 4'b0001; // Set input values
        #period;
        if (!(pm === 4'b0001 && hh === 7'b0010010 && mm === 7'b0000000 && ss === 7'b0000100)) begin
            $display("Mismatch at index 19: Inputs = ['Low' "4'b0000" "4'b0001"], Generated = ['pm', 'hh', 'mm', 'ss'], Reference = ["4'b0001", "7'b0010010", "7'b0000000", "7'b0000100"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 20);
        $finish;
    end

endmodule