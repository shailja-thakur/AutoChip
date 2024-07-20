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

    reg [1:0] pht [127:0];
    reg [6:0] global_history;

    // Prediction Logic
    wire [6:0] predict_index = predict_pc ^ global_history;
    always @(*) begin
        if (predict_valid) begin
            predict_taken = pht[predict_index][1];
            predict_history = global_history;
        end
        else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

    // Training Logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b10;
            end
        end
        else begin
            if (train_valid) begin
                // Update PHT
                wire [6:0] train_index = train_pc ^ train_history;
                if (train_taken) begin
                    if (pht[train_index] != 2'b11)
                        pht[train_index] <= pht[train_index] + 1'b1;
                end
                else begin
                    if (pht[train_index] != 2'b00)
                        pht[train_index] <= pht[train_index] - 1'b1;
                end

                // Update global history
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
                else begin
                    global_history <= (global_history << 1) | train_taken;
                end
            end
        end
    end

endmodule
