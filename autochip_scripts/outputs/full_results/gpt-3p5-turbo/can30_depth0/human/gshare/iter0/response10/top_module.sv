module top_module(
    input clk,
    input areset, 

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken, 
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history, 
    input [6:0] train_pc
);

  reg [6:0] branch_history;
  reg [6:0] index;
  reg [1:0] predict_state;
  reg [1:0] train_state;
  reg [1:0] mispredict_state;
  reg [1:0] actual_state;
  reg [1:0] next_state;
  reg [1:0] predicted_taken;
  reg [6:0] branch_pc;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset branch history register
      branch_history <= 7'b0;
    end else begin
      // Update branch history register
      branch_history <= {branch_history[5:0], predicted_taken};
    end
  end

  always @(posedge clk) begin
    if (predict_valid) begin
      // Get the index for the pattern history table
      index <= predict_pc ^ branch_history;

      // Predict the branch direction
      predict_taken <= (predict_state == 2'b10 || predict_state == 2'b11);

      // Store the current branch pc and history
      branch_pc <= predict_pc;
      predict_history <= branch_history;
    end else if (train_valid) begin
      // Get the index for the pattern history table
      index <= train_pc ^ train_history;

      // Get the predicted and actual states
      predict_state <= predict_taken ? (predict_state == 2'b00 ? 2'b01 : (predict_state == 2'b01 ? 2'b11 : 2'b10)) : (predict_state == 2'b10 ? 2'b00 : (predict_state == 2'b11 ? 2'b01 : 2'b11));
      actual_state <= train_taken ? (train_mispredicted ? (mispredict_state == 2'b00 ? 2'b01 : (mispredict_state == 2'b01 ? 2'b11 : 2'b10))) : 2'b00;

      // Update the pattern history table
      case (next_state)
        2'b00: // Strongly not taken
          if (!train_mispredicted) next_state <= 2'b00;
          else next_state <= (mispredict_state == 2'b01 ? 2'b00 : (mispredict_state == 2'b00 ? 2'b01 : 2'b00));
        2'b01: // Weakly not taken
          if (train_taken) next_state <= 2'b10;
          else next_state <= 2'b00;
        2'b10: // Weakly taken
          if (train_taken) next_state <= 2'b11;
          else next_state <= 2'b01;
        2'b11: // Strongly taken
          if (train_mispredicted) next_state <= (mispredict_state == 2'b10 ? 2'b11 : (mispredict_state == 2'b11 ? 2'b10 : 2'b11));
          else next_state <= 2'b10;
        default: next_state <= 2'b00;
      endcase
    end
  end

  always @(posedge clk) begin
    if (train_valid) begin
      mispredict_state <= actual_state;
      train_state <= predict_state;
    end

    if (train_valid || predict_valid) begin
      // Update branch history register at next positive clock edge
      branch_history <= {branch_history[5:0], predicted_taken};
    end
  end

endmodule
