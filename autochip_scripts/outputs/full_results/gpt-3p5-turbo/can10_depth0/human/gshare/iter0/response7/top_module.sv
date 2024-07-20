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

reg [6:0] pht_index;
reg [1:0] pht_counter [0:127];
reg [6:0] gh_register;
reg [6:0] predicted_history;

assign predict_taken = (pht_counter[pht_index] == 2'b10 || pht_counter[pht_index] == 2'b11);
assign predict_history = predicted_history;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    pht_index <= 0;
    gh_register <= 0;
    predicted_history <= 0;
    for (int i = 0; i < 128; i = i + 1)
      pht_counter[i] <= 0;
  end else begin
    if (predict_valid) begin
      pht_index <= predict_pc ^ gh_register;
      predicted_history <= gh_register;
    end else begin
      pht_index <= train_pc ^ train_history;
      gh_register <= {gh_register[5:0], train_taken};
      if (train_mispredicted) begin
        pht_counter[pht_index] <= (pht_counter[pht_index] == 2'b00) ? 2'b00 : (pht_counter[pht_index] - 2'b01);
      end else begin
        pht_counter[pht_index] <= (pht_counter[pht_index] == 2'b11) ? 2'b11 : (pht_counter[pht_index] + 2'b01);
      end
    end
  end
end

endmodule
