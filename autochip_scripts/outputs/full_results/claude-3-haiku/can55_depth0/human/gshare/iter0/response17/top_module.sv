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

localparam PHT_SIZE = 128;
localparam HISTORY_SIZE = 7;

reg [1:0] pht [PHT_SIZE-1:0];
reg [HISTORY_SIZE-1:0] history_reg;

// Prediction logic
wire [6:0] predict_index = predict_pc ^ history_reg;
assign predict_taken = pht[predict_index][1];
assign predict_history = history_reg;

// Training logic
wire [6:0] train_index = train_pc ^ train_history;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        history_reg <= 0;
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b01;
        end
    end
    else begin
        if (train_valid) begin
            // Update PHT
            if (train_taken) begin
                pht[train_index] <= (pht[train_index] == 2'b11) ? 2'b11 : pht[train_index] + 1'b1;
            end
            else begin
                pht[train_index] <= (pht[train_index] == 2'b00) ? 2'b00 : pht[train_index] - 1'b1;
            end

            // Update history register
            if (train_mispredicted) begin
                history_reg <= train_history;
            end
            else begin
                history_reg <= (history_reg << 1) | train_taken;
            end
        end
        else if (predict_valid) begin
            // Update history register
            history_reg <= (history_reg << 1) | predict_taken;
        end
    end
end

endmodule
