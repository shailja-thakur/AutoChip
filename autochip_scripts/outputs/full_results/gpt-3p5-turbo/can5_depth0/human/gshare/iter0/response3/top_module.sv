module gshare_predictor(
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

  reg [6:0] pht_index;
  reg [1:0] pht_state;
  reg [6:0] history_register;
  reg [6:0] ghr_index;
  
  reg [6:0] predict_history_reg;
  wire predict_taken_reg;
  
  // Combinational logic for prediction
  always @(posedge clk or posedge areset) begin
    if (areset)
      predict_history_reg <= 7'b0;
    else if (predict_valid) begin
      predict_history_reg <= history_register;
    end
  end
  
  // Sequential logic for updates
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      history_register <= 7'b0;
      pht_index <= 7'b0;
      pht_state <= 2'b0;
      ghr_index <= 7'b0;
    end else if (train_valid) begin
      if (train_mispredicted) begin
        pht_state <= 2'b0;
        history_register <= train_history;
        ghr_index <= train_history ^ predict_pc;
      end else begin
        pht_state <= pht_state + 1;
        history_register <= train_history;
        ghr_index <= train_history ^ predict_pc;
      end
      pht_index <= ghr_index ^ predict_pc;
    end else if (predict_valid) begin
      ghr_index <= predict_history_reg ^ predict_pc;
      pht_index <= ghr_index ^ predict_pc;
    end
  end
  
  // Output assignments
  assign predict_taken = predict_taken_reg;
  assign predict_history = predict_history_reg;
  
  // Logic for predicting branch direction
  gshare_predictor_logic u1 (
    .clk(clk),
    .areset(areset),
    .pht_index(pht_index),
    .pht_state(pht_state),
    .predict_taken(predict_taken_reg)
  );
  
endmodule
module gshare_predictor_logic(
  input clk,
  input areset,
  input [6:0] pht_index,
  input [1:0] pht_state,
  output predict_taken
);

  reg predict_taken_reg;

  always @(posedge clk or posedge areset) begin
    if (areset)
      predict_taken_reg <= 1'b0;
    else begin
      case (pht_state)
        0: predict_taken_reg <= 1'b0;
        1: predict_taken_reg <= 1'b0;
        2: predict_taken_reg <= 1'b1;
        3: predict_taken_reg <= 1'b1;
      endcase
    end
  end

  assign predict_taken = predict_taken_reg;
  
endmodule
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

  wire predict_taken_reg;
  wire [6:0] predict_history_reg;
  wire [6:0] ghr_index_train;
  
  gshare_predictor u1 (
    .clk(clk),
    .areset(areset),
    .predict_valid(predict_valid),
    .predict_pc(predict_pc),
    .predict_taken(predict_taken_reg),
    .predict_history(predict_history_reg),
    .train_valid(train_valid),
    .train_taken(train_taken),
    .train_mispredicted(train_mispredicted),
    .train_history(train_history),
    .train_pc(train_pc)
  );
  
  assign predict_taken = predict_taken_reg;
  assign predict_history = predict_history_reg;
  
endmodule
