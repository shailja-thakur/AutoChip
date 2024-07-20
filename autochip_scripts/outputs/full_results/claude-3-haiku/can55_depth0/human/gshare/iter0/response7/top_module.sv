module gshare_predictor (
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
reg [1:0] pht [PHT_SIZE-1:0];
reg [6:0] global_history;

// Prediction logic
always @(*) begin
    if (predict_valid) begin
        // Hash the PC and global history to get the PHT index
        predict_taken = pht[predict_pc ^ global_history][1];
        predict_history = global_history;
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b10;
        end
    end else begin
        if (train_valid) begin
            // Update the PHT entry based on the actual branch outcome
            if (train_taken) begin
                pht[train_pc ^ train_history][1] <= 1'b1;
            end else begin
                pht[train_pc ^ train_history][1] <= 1'b0;
            end

            // Update the global history register
            if (train_mispredicted) begin
                // Recover the global history to the state before the mispredicted branch
                global_history <= train_history;
            end else begin
                // Update the global history with the actual branch outcome
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end
end

endmodule
