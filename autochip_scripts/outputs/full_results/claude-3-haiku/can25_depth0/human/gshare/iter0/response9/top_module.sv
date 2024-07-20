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

reg [1:0] pht[127:0];
reg [6:0] global_history;

always @(*) begin
    if (predict_valid) begin
        // Hash the PC and global history to get the PHT index
        predict_history = global_history;
        predict_taken = (pht[predict_pc ^ global_history][1]);
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01;
        end
    end
    else begin
        // Update global history
        if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
        // Train the predictor
        if (train_valid) begin
            // Update the PHT
            pht[train_pc ^ train_history] <= (train_taken) ? 2'b11 : 2'b00;
            // Recover global history on misprediction
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
