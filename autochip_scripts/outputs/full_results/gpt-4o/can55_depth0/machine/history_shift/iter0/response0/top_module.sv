module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output reg [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset
        predict_history <= 32'b0;
    end else begin
        if (train_mispredicted) begin
            // Update predict_history with train_history and train_taken
            if (train_taken) begin
                predict_history <= train_history;
            end else begin
                predict_history <= 0;
            end
        end else if (predict_valid) begin
            // Update predict_history with the current prediction
            predict_history <= (predict_history << 1) | (predict_taken ? 1'b1 : 1'b0);
        end
    end
end

endmodule
