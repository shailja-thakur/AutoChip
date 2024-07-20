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

  logic [31:0] history_reg;

  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset
        history_reg <= 32'b0;
    end else if (train_mispredicted) begin
        // Load the branch history register with the history after the completion of the mispredicted branch
        history_reg <= {train_history[30:0], train_taken};
    end else if (predict_valid) begin
        // Update branch history for the predicted branch
        history_reg <= {history_reg[30:0], predict_taken};
    end
  end

  // Output the current history
  assign predict_history = history_reg;

endmodule
