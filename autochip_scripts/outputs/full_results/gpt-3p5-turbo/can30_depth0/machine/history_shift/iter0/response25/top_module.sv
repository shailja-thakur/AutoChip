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

// Register to store the value of predict_history
logic [31:0] reg_predict_history;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        // Reset the value of predict_history
        reg_predict_history <= 0;
    end else begin
        if (train_mispredicted) begin
            // Update predict_history with train_history and train_taken
            reg_predict_history <= {reg_predict_history[30:0], train_taken};
        end else if (predict_valid) begin
            // Update predict_history with predict_taken
            reg_predict_history <= {reg_predict_history[30:0], predict_taken};
        end
    end
end

// Assign the value of reg_predict_history to the output port
assign predict_history = reg_predict_history;

endmodule
