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
reg [1:0] pht[PHT_SIZE-1:0];
reg [6:0] global_history;

always @(*) begin
    // Compute the PHT index using XOR hash of PC and global history
    integer pht_index;
    pht_index = predict_pc ^ global_history;

    // Predict the branch direction based on the PHT entry
    predict_taken = (pht[pht_index] >= 2'd2);
    predict_history = global_history;
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (integer i = 0; i < PHT_SIZE; i = i + 1) begin
            pht[i] <= 2'b01;
        end
    end
    else begin
        // Update the PHT and global history based on the training input
        if (train_valid) begin
            integer train_pht_index;
            train_pht_index = train_pc ^ train_history;

            // Update the PHT entry
            if (train_taken) begin
                if (pht[train_pht_index] != 2'b11)
                    pht[train_pht_index] <= pht[train_pht_index] + 1'b1;
            end
            else begin
                if (pht[train_pht_index] != 2'b00)
                    pht[train_pht_index] <= pht[train_pht_index] - 1'b1;
            end

            // Recover the global history if the branch was mispredicted
            if (train_mispredicted)
                global_history <= train_history;
            else
                global_history <= (global_history << 1) | train_taken;
        end
    end
end

endmodule
