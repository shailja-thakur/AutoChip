module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] reg_q;

  always @(posedge clk) begin
    if (reset) begin
      q <= 32'h1;
      reg_q <= 32'h1;
    end else begin
      reg_q <= {reg_q[30:0], reg_q[22] ^ reg_q[21] ^ reg_q[1] ^ reg_q[0]};
      q <= reg_q;
    end
  end

endmodule
