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

reg [1:0] predict_state;
reg [1:0] pht [0:127];
reg [6:0] branch_history;
reg predict_taken;

// Predict Branch Direction
always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history <= 0;
        predict_state <= 0;
    end else begin
        if (predict_valid) begin
            predict_history <= branch_history;
            predict_taken <= (pht[predict_pc ^ branch_history] == 2 ||
                             pht[predict_pc ^ branch_history] == 3);
        end else if (train_valid) begin
            if (train_mispredicted) begin
                branch_history <= train_history;
            end else begin
                branch_history <= {branch_history[5:0], train_taken};
                pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] +
                                                 {1'b0, train_taken};
            end
        end
    end
end

endmodule
