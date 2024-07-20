module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

// If reset is asserted, reset the predict_history signal to 0
always_ff @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        predict_history <= 0;
    end
end

// Check the train_mispredicted and predict_valid signals
always_ff @(posedge clk) begin
    if (areset == 1'b0) begin
        // Update the predict_history signal with the train_history and train_taken signals
        if (train_mispredicted == 1'b1) begin
            predict_history <= {predict_history[30:0], train_taken};
        end
        
        // Update the predict_history signal with the predict_taken signal
        if (predict_valid == 1'b1) begin
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end
end

endmodule
