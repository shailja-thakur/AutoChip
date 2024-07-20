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
    // Prediction logic
    if (predict_valid) begin
        predict_taken = pht[predict_pc ^ global_history][1];
        predict_history = global_history;
    end else begin
        predict_taken = 1'b0;
        predict_history = 7'b0;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01;
        end
    end else begin
        // Training logic
        if (train_valid) begin
            // Update the PHT
            pht[train_pc ^ train_history] <= (train_taken) ? 2'b11 : 2'b00;

            // Recover the global history register on misprediction
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                global_history <= (train_taken) ? (global_history << 1) | 1'b1 : (global_history << 1);
            end
        end else begin
            // Update the global history register for predicted branches
            if (predict_valid) begin
                global_history <= (predict_taken) ? (global_history << 1) | 1'b1 : (global_history << 1);
            end
        end
    end
end

endmodule
