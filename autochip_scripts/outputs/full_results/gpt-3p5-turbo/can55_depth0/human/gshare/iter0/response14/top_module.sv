module top_module (
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

  reg [6:0] g_history;
  reg [6:0] p_history;
  wire [6:0] index;

  reg [1:0] pht [0:127];

  integer predict_index;
  reg [1:0] predict_outcome;

  reg [6:0] train_index;
  integer train_counter;
  reg [1:0] train_outcome;
  reg train_flush;

  // Gshare branch prediction
  always @(posedge clk or posedge areset) begin
    if (areset)
      g_history <= 0;
    else begin
      if (predict_valid) begin
        predict_index <= (predict_pc ^ g_history) & 7'b1111111;
        predict_outcome <= pht[predict_index];
      end
      
      if (train_valid) begin
        train_index <= (train_pc ^ train_history) & 7'b1111111;
        train_outcome <= train_taken;
        if (train_mispredicted)
          train_flush <= 1;
        else
          train_flush <= 0;
      end
    end
  end

  // PHT update
  always @(posedge clk or posedge areset) begin
    if (areset)
      p_history <= 0;
    else begin
      if (predict_valid) begin
        predict_taken <= predict_outcome[1];
        predict_history <= p_history;
      end

      if (train_valid && ~train_flush) begin
        pht[train_index] <= pht[train_index] + (train_outcome ? 2'b11 : 2'b01);

        if (g_history[0] == 1)
          pht[train_index-1] <= pht[train_index-1] + (train_outcome ? 2'b11 : 2'b01);
        else
          pht[train_index+1] <= pht[train_index+1] + (train_outcome ? 2'b11 : 2'b01);
      end
      else if (train_flush) begin
        g_history[0] <= train_history[0];
        p_history[0] <= train_history[0];
      end
    end
  end

endmodule
