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

    // 7-bit global history register
    reg [6:0] global_history;

    // 128-entry pattern history table (PHT)
    reg [1:0] pht[127:0];

    // Hash function to get the 7-bit index into the PHT
    function [6:0] hash(input [6:0] pc, input [6:0] history);
        hash = pc ^ history;
    endfunction

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b00;
            end
        end
        else begin
            // Handle prediction requests
            if (predict_valid) begin
                // Hash the PC and history to get the PHT index
                reg [6:0] index = hash(predict_pc, global_history);

                // Make the prediction and output it
                predict_taken <= (pht[index] >= 2'b10);
                predict_history <= global_history;
            end

            // Handle training requests
            if (train_valid) begin
                // Hash the PC and history to get the PHT index
                reg [6:0] index = hash(train_pc, train_history);

                // Update the PHT based on the actual branch outcome
                if (train_taken) begin
                    if (pht[index] != 2'b11) pht[index] <= pht[index] + 1;
                end
                else begin
                    if (pht[index] != 2'b00) pht[index] <= pht[index] - 1;
                end

                // If the branch was mispredicted, update the global history
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
                else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
        end
    end

endmodule
