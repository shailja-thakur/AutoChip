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

    // 7-bit global branch history register
    reg [6:0] global_history;

    // 128-entry pattern history table (PHT)
    reg [1:0] pht[127:0];

    // Hashing function for indexing the PHT
    function [6:0] hash_index;
        input [6:0] pc;
        input [6:0] history;
        begin
            hash_index = pc ^ history;
        end
    endfunction

    // Prediction logic
    always @* begin
        if (predict_valid) begin
            // Hash the PC and global history to get the PHT index
            integer index = hash_index(predict_pc, global_history);

            // Predict the branch direction based on the PHT state
            predict_taken = (pht[index] >= 2'b10);

            // Output the current global history
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (integer i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b01;
            end
        end else begin
            if (train_valid) begin
                // Hash the training PC and history to get the PHT index
                integer index = hash_index(train_pc, train_history);

                // Update the PHT based on the actual branch outcome
                if (train_taken) begin
                    pht[index] <= (pht[index] == 2'b11) ? 2'b11 : pht[index] + 1'b1;
                end else begin
                    pht[index] <= (pht[index] == 2'b00) ? 2'b00 : pht[index] - 1'b1;
                end

                // Update the global history register
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
        end
    end

endmodule
