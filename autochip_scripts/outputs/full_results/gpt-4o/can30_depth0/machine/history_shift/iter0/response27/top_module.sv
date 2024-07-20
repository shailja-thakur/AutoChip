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
        predict_history <= 32'b0; // Reset the predict_history to 0
    end
    else begin
        if (train_mispredicted) begin
            // If there was a misprediction, update the predict_history with train_history and train_taken
            predict_history <= {train_history[30:0], train_taken};
        end
        else if (predict_valid) begin
            // If the prediction is valid, update the predict_history with predict_taken
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end
end

endmodule
