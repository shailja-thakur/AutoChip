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

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 32'd0;
        end else begin
            if (train_mispredicted) begin
                // Update predict_history based on training signals
                predict_history <= {train_history[30:0], train_taken};
            end else if (predict_valid) begin
                // Update predict_history based on prediction
                predict_history <= {predict_history[30:0], predict_taken};
            end
        end
    end

endmodule
