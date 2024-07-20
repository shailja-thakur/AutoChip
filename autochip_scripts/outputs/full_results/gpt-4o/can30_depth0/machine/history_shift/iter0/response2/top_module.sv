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

    // Initialize the predict_history to 0
    initial predict_history = 32'b0;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the predict_history to zero
            predict_history <= 32'b0;
        end else begin
            if (train_mispredicted) begin
                // Update the predict_history with the train_history when a misprediction occurs
                predict_history <= {train_history[30:0], train_taken};
            end else if (predict_valid) begin
                // Update the predict_history with the new prediction when prediction is valid
                predict_history <= {predict_history[30:0], predict_taken};
            end
        end
    end

endmodule
