module gshare_predictor (
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
            pht[i] <= 2'b10;
        end
    end
    else begin
        if (train_valid) begin
            // Update PHT
            pht[train_pc ^ train_history] <= (train_taken) ? 2'b11 : 2'b00;

            // Recover global history on misprediction
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end

        // Update global history
        if (predict_valid) begin
            global_history <= (predict_taken) ? {global_history[5:0], 1'b1} : {global_history[5:0], 1'b0};
        end
    end
end

// Prediction logic
assign predict_taken = pht[predict_pc ^ global_history][1];
assign predict_history = global_history;

endmodule
