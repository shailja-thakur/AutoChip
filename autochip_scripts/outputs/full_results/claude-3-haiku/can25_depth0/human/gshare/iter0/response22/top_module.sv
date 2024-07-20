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

reg [6:0] global_history;
reg [1:0] pht [127:0];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01;
        end
    end
    else begin
        if (train_valid) begin
            // Train the branch predictor
            pht[train_pc ^ train_history] <= (train_taken) ? pht[train_pc ^ train_history] + 2'b01 : pht[train_pc ^ train_history] - 2'b01;
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end
        if (predict_valid) begin
            // Predict the branch
            predict_taken <= pht[predict_pc ^ global_history][1];
            predict_history <= global_history;
            global_history <= {global_history[5:0], predict_taken};
        end
    end
end

endmodule
