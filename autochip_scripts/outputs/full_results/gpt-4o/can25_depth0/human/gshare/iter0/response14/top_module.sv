module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // 128-entry table of 2-bit saturating counters
    reg [1:0] pattern_history_table[127:0];

    // 7-bit global history register
    reg [6:0] global_history_reg;

    // Initializing the pattern history table and global history register
    integer i;
    always @(posedge areset) begin
        if (areset) begin
            global_history_reg <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                pattern_history_table[i] <= 2'b01; // Weakly taken initial state
            end
        end
    end

    // Prediction
    always @(*) begin
        if (predict_valid) begin
            // Hash pc and global history register (using xor) into a 7-bit index
            predict_history = global_history_reg;
            predict_taken = pattern_history_table[predict_pc ^ global_history_reg][1];
        end else begin
            predict_taken = 0;
            predict_history = global_history_reg;
        end
    end

    // Training
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history_reg <= 7'b0;
        end else if (train_valid) begin
            // Update the pattern history table
            if (train_taken) begin
                if (pattern_history_table[train_pc ^ train_history] != 2'b11) begin
                    pattern_history_table[train_pc ^ train_history] <= pattern_history_table[train_pc ^ train_history] + 1;
                end
            end else begin
                if (pattern_history_table[train_pc ^ train_history] != 2'b00) begin
                    pattern_history_table[train_pc ^ train_history] <= pattern_history_table[train_pc ^ train_history] - 1;
                end
            end

            // Update the global history register
            if (train_mispredicted) begin
                global_history_reg <= {global_history_reg[5:0], train_taken};
            end else begin
                global_history_reg <= {global_history_reg[5:0], train_taken};
            end
        end else if (predict_valid) begin
            // Update the global history register for the predicted branch
            global_history_reg <= {global_history_reg[5:0], predict_taken};
        end
    end

endmodule
