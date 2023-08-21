module top_module_tb;

    reg clk;
    reg areset;
    reg bump_left;
    reg bump_right;
    reg ground;
    reg dig;

    wire walk_left;
    wire walk_right;
    wire aaah;
    wire digging;


    top_module UUT (.clk(clk), .areset(areset), .bump_left(bump_left), .bump_right(bump_right), .ground(ground), .dig(dig), .walk_left(walk_left), .walk_right(walk_right), .aaah(aaah), .digging(digging));

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

        // Tick 0: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0001, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0001, 4'b0000, 4'b0000, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0001; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0001 && walk_right === 4'b0000 && aaah === 4'b0000 && digging === 4'b0000)) begin
            $display("Mismatch at index 0: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0001" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0001", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0001, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0001, 4'b0000, 4'b0000, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0001; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0001 && walk_right === 4'b0000 && aaah === 4'b0000 && digging === 4'b0000)) begin
            $display("Mismatch at index 1: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0001" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0001", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0001, 4'b0000, 4'b0000, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0001 && walk_right === 4'b0000 && aaah === 4'b0000 && digging === 4'b0000)) begin
            $display("Mismatch at index 2: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0001", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0001, 4'b0000, 4'b0000, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0001 && walk_right === 4'b0000 && aaah === 4'b0000 && digging === 4'b0000)) begin
            $display("Mismatch at index 3: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0001", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 4: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 5: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 6: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 7: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 8: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 9: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 10: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 11: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 12: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 13: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 14: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 15: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 16: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 17: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 18: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 19: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 20: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 21: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 21 passed!");
        end

        // Tick 22: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 22: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 22 passed!");
        end

        // Tick 23: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 23: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 23 passed!");
        end

        // Tick 24: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 24: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 24 passed!");
        end

        // Tick 25: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 25: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 25 passed!");
        end

        // Tick 26: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 26: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 26 passed!");
        end

        // Tick 27: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 27: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 27 passed!");
        end

        // Tick 28: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 28: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 28 passed!");
        end

        // Tick 29: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 29: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 29 passed!");
        end

        // Tick 30: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 30: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 30 passed!");
        end

        // Tick 31: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 31: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 31 passed!");
        end

        // Tick 32: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 32: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 32 passed!");
        end

        // Tick 33: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 33: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 33 passed!");
        end

        // Tick 34: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 34: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 34 passed!");
        end

        // Tick 35: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 35: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 35 passed!");
        end

        // Tick 36: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 36: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 36 passed!");
        end

        // Tick 37: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 37: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 37 passed!");
        end

        // Tick 38: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 38: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 38 passed!");
        end

        // Tick 39: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 39: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 39 passed!");
        end

        // Tick 40: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 40: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 40 passed!");
        end

        // Tick 41: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 41: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 41 passed!");
        end

        // Tick 42: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 42: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 42 passed!");
        end

        // Tick 43: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 43: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 43 passed!");
        end

        // Tick 44: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 44: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 44 passed!");
        end

        // Tick 45: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 45: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 45 passed!");
        end

        // Tick 46: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 46: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 46 passed!");
        end

        // Tick 47: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 47: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 47 passed!");
        end

        // Tick 48: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 48: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 48 passed!");
        end

        // Tick 49: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0000; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 49: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0000" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 49 passed!");
        end

        // Tick 50: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0001, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0001; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 50: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0001" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 50 passed!");
        end

        // Tick 51: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0001, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0001, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0001; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0001 && digging === 4'b0000)) begin
            $display("Mismatch at index 51: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0001" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0001", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 51 passed!");
        end

        // Tick 52: Inputs = High, 4'b0000, 4'b0000, 4'b0000, 4'b0001, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0001; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0000 && digging === 4'b0000)) begin
            $display("Mismatch at index 52: Inputs = ['High' "4'b0000" "4'b0000" "4'b0000" "4'b0001" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 52 passed!");
        end

        // Tick 53: Inputs = Low, 4'b0000, 4'b0000, 4'b0000, 4'b0001, 4'b0000, Generated = walk_left, walk_right, aaah, digging, Reference = 4'b0000, 4'b0000, 4'b0000, 4'b0000
        areset = 4'b0000; bump_left = 4'b0000; bump_right = 4'b0000; ground = 4'b0001; dig = 4'b0000; // Set input values
        #period;
        if (!(walk_left === 4'b0000 && walk_right === 4'b0000 && aaah === 4'b0000 && digging === 4'b0000)) begin
            $display("Mismatch at index 53: Inputs = ['Low' "4'b0000" "4'b0000" "4'b0000" "4'b0001" "4'b0000"], Generated = ['walk_left', 'walk_right', 'aaah', 'digging'], Reference = ["4'b0000", "4'b0000", "4'b0000", "4'b0000"]");
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 53 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 54);
        $finish;
    end

endmodule