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

localparam PHT_SIZE = 128;
localparam HISTORY_SIZE = 7;

reg [1:0] pht [PHT_SIZE-1:0];
reg [HISTORY_SIZE-1:0] global_history;

// Prediction logic
always @* begin
    if (predict_valid) begin
        // Hash the PC and global history to get the PHT index
        integer pht_index = predict_pc ^ global_history;
        // Get the prediction from the PHT
        predict_taken = (pht[pht_index] >= 2'b10);
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
        for (integer i = 0; i < PHT_SIZE; i = i + 1) begin
            pht[i] <= 2'b01;
        end
    end else begin
        if (train_valid) begin
            // Hash the PC and global history to get the PHT index
            integer pht_index = train_pc ^ train_history;
            // Update the PHT entry based on the actual branch outcome
            if (train_taken) begin
                pht[pht_index] <= (pht[pht_index] == 2'b11) ? 2'b11 : pht[pht_index] + 2'b01;
            end else begin
                pht[pht_index] <= (pht[pht_index] == 2'b00) ? 2'b00 : pht[pht_index] - 2'b01;
            end
            // If the branch was mispredicted, recover the global history
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                // Update the global history
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end
end

endmodule
