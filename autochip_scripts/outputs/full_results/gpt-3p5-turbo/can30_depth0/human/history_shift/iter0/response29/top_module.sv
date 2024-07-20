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

reg [31:0] history_shift_register;
reg [31:0] temp_history_shift_register;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        history_shift_register <= 0;
    end else if (train_mispredicted) begin
        // Concatenate the train_history and train_taken
        temp_history_shift_register <= {train_history, train_taken};
    end else if (predict_valid) begin
        // Shift in predict_taken to update the branch history
        temp_history_shift_register <= {predict_history[30:0], predict_taken};
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history <= 0;
    end else if (train_mispredicted) begin
        // Load the branch history register with temp_history_shift_register after a misprediction
        predict_history <= temp_history_shift_register;
    end else if (predict_valid) begin
        // Update the branch history register with the shifted history
        predict_history <= temp_history_shift_register;
    end
end

endmodule
