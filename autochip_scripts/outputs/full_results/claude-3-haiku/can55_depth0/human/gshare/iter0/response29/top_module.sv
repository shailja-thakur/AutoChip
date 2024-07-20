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
reg [6:0] history_reg;

always @(*) begin
    // Prediction logic
    if (predict_valid) begin
        // Hash the PC and history to get the PHT index
        predict_taken = pht[predict_pc ^ history_reg][1];
        predict_history = history_reg;
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        history_reg <= 0;
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b10;
        end
    end else begin
        // Training logic
        if (train_valid) begin
            // Update PHT
            if (train_taken) begin
                if (pht[train_pc ^ train_history] != 2'b11)
                    pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1;
            end else begin
                if (pht[train_pc ^ train_history] != 2'b00)
                    pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1;
            end

            // Update history register
            if (train_mispredicted) begin
                history_reg <= train_history;
            end else begin
                history_reg <= (history_reg << 1) | train_taken;
            end
        end
    end
end

endmodule
