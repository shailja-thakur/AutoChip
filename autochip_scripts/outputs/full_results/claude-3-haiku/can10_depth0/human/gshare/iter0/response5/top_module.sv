module top_module (
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
            predict_taken = pht[predict_index][1];
            predict_history = global_history;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < PHT_SIZE; i++) begin
                pht[i] <= 2'b10;
            end
        end
        else begin
            if (train_valid) begin
                wire [6:0] train_index = train_pc ^ train_history;
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
                else begin
                    global_history <= (global_history << 1) | train_taken;
                end
                if (train_taken) begin
                    pht[train_index] <= (pht[train_index] == 2'b00) ? 2'b00 : (pht[train_index] - 1);
                end
                else begin
                    pht[train_index] <= (pht[train_index] == 2'b11) ? 2'b11 : (pht[train_index] + 1);
                end
            end
            else begin
                global_history <= (global_history << 1) | predict_taken;
            end
        end
    end

endmodule
