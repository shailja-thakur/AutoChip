module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);

  reg [3:0] q_reg;
  reg areset_sync;
  
  always @(posedge clk) begin
    areset_sync <= areset;
    if (areset_sync == 1) begin
      q_reg <= 4'b0000;
    end else if (load == 1) begin
      q_reg <= data;
    end else if (ena == 1) begin
      q_reg <= {q_reg[2:0], q_reg[3]};
    end
  end
  
  always @(posedge clk) begin
    q <= q_reg;
  end

endmodule
