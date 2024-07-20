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
        predict_history <= 32'b0; // Resetting history to 0 on reset
    end else begin
        if (train_mispredicted) begin
            // If mispredicted, update with training history and train_taken signal
            predict_history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // If the prediction is valid, update with predict_taken signal
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end
end

endmodule
