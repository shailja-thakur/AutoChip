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

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history <= 32'b0; // Reset predict_history to 0
    end
    else begin
        if (train_mispredicted) begin
            predict_history <= {train_history[30:0], train_taken}; // Update predict_history with train history and taken signal
        end
        else if (predict_valid) begin
            predict_history <= {predict_history[30:0], predict_taken}; // Update predict_history with predict_taken signal
        end
    end
end

endmodule
