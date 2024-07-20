module top_module(
    input clk,
    input areset, 

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken, 
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history, 
    input [6:0] train_pc
);

    // Define a 128-entry table of 2-bit saturating counters
    reg [1:0] pattern_history_table [0:127];
    
    // Define the global branch history register
    reg [6:0] global_branch_history;

    // For the output signal
    reg predict_taken_reg;

    // Reset logic: asynchronous active-high
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                pattern_history_table[i] <= 2'b10; // Initialize to weakly taken
            end
            global_branch_history <= 7'b0;
        end
        else begin
            if (train_valid) begin
                // Calculate index from history and pc using XOR
                integer train_index;
                train_index = train_pc ^ train_history;

                // Update the pattern history table
                if (train_taken) begin
                    if (pattern_history_table[train_index] < 2'b11) begin
                        pattern_history_table[train_index] <= pattern_history_table[train_index] + 2'b01;
                    end
                end else begin
                    if (pattern_history_table[train_index] > 2'b00) begin
                        pattern_history_table[train_index] <= pattern_history_table[train_index] - 2'b01;
                    end
                end

                // Update global history if misprediction happened
                if (train_mispredicted) begin
                    global_branch_history <= (train_history << 1) | train_taken;
                end
            end 

            if (predict_valid && !train_valid) begin
                // Update global history register immediately after prediction
                global_branch_history <= (global_branch_history << 1) | predict_taken_reg;
            end
        end
    end

    // Prediction logic: calculate index and read the PHT to give prediction
    always @(*) begin
        if (predict_valid) begin
            integer predict_index;
            predict_index = predict_pc ^ global_branch_history;
            predict_taken_reg = pattern_history_table[predict_index] >= 2'b10;
        end else begin
            predict_taken_reg = 1'b0;
        end
    end

    // Assign the outputs
    assign predict_taken = predict_taken_reg;
    assign predict_history = global_branch_history;

endmodule
