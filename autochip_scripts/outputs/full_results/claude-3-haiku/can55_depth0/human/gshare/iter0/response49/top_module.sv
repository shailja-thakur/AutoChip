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

    parameter PHT_SIZE = 128;
    reg [1:0] pht[PHT_SIZE-1:0];
    reg [6:0] global_history;

    // Prediction logic
    wire [6:0] predict_index = predict_pc ^ global_history;
    always @(*) begin
        if (predict_valid) begin
            predict_taken = (pht[predict_index] >= 2'b10);
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    wire [6:0] train_index = train_pc ^ train_history;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < PHT_SIZE; i++) begin
                pht[i] <= 2'b01;
            end
        end else begin
            if (train_valid) begin
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= (global_history << 1) | train_taken;
                end
                pht[train_index] <= (train_taken) ? (pht[train_index] + 2'b01) : (pht[train_index] - 2'b01);
            end
        end
    end

endmodule
