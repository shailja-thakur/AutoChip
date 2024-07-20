module top_module (
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

logic [31:0] history_reg;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        history_reg <= '0;
    end
    else if (train_mispredicted) begin
        // When a branch misprediction occurs, load the branch history register with the history after the completion of the mispredicted branch.
        // This is the history before the mispredicted branch (train_history) concatenated with the actual result of the branch (train_taken).
        history_reg <= {train_history, train_taken};
    end
    else if (predict_valid) begin
        // When a branch prediction is made, shift in predict_taken from the LSB side to update the branch history for the predicted branch.
        history_reg <= {history_reg[30:0], predict_taken};
    end
end

assign predict_history = history_reg;

endmodule
