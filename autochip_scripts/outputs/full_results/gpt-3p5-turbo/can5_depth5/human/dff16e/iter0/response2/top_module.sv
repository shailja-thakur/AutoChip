module top_module(
  input clk,
  input reset_n,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);

  reg [15:0] q_reg;
  
  always @(posedge clk) begin
    if (reset_n == 0) begin
      q_reg <= 16'b0;
    end else begin
      if (byteena[0] == 1) begin
        q_reg[7:0] <= d[7:0];
      end
      if (byteena[1] == 1) begin
        q_reg[15:8] <= d[15:8];
      end
    end
  end

  assign q = q_reg;

endmodule
