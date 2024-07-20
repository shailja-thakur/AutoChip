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
localparam HIST_SIZE = 7;

reg [1:0] pht [PHT_SIZE-1:0];
reg [HIST_SIZE-1:0] global_history;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b01;
        end
    end
    else begin
        // Prediction logic
        if (predict_valid) begin
            // Hash the PC and global history to get the PHT index
            integer pht_index = predict_pc ^ global_history;
            pht_index = pht_index[HIST_SIZE-1:0];

            // Make the prediction and update the global history
            predict_taken <= pht[pht_index][1];
            predict_history <= global_history;
            global_history <= {global_history[HIST_SIZE-2:0], predict_taken};
        end

        // Training logic
        if (train_valid) begin
            // Hash the training PC and history to get the PHT index
            integer train_index = train_pc ^ train_history;
            train_index = train_index[HIST_SIZE-1:0];

            // Update the PHT entry
            if (train_taken)
                pht[train_index] <= (pht[train_index] == 2'b11) ? 2'b11 : pht[train_index] + 1'b1;
            else
                pht[train_index] <= (pht[train_index] == 2'b00) ? 2'b00 : pht[train_index] - 1'b1;

            // Update the global history
            if (train_mispredicted)
                global_history <= train_history;
            else
                global_history <= {global_history[HIST_SIZE-2:0], train_taken};
        end
    end
end

endmodule
