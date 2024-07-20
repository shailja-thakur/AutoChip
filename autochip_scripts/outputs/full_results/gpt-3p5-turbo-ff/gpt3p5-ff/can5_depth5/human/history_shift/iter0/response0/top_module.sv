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

  // shift register to store branch history
  reg [31:0] history_register;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // reset the history counter to zero
      history_register <= 0;
    end else begin
      if (train_mispredicted) begin
        // load the branch history register with the history after the completion of the mispredicted branch
        // concatenating train_history with train_taken
        history_register <= {train_history, train_taken};
      end else if (predict_valid) begin
        // shift in predict_taken from the LSB side to update the branch history for the predicted branch
        history_register <= {history_register[30:0], predict_taken};
      end
    end
  end

  // assign the value of the branch history register to the output port
  assign predict_history = history_register;

endmodule
