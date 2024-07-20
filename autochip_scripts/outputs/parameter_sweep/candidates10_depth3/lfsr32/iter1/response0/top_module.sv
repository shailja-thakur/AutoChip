module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q; // Next state of q

  always @(posedge clk or posedge reset) begin
    if (reset)
      next_q <= 32'b1;
    else
      next_q <= {q[31]^q[21]^q[1]^q[0], q[31:1]};
  end
  
  always @(posedge clk) begin
    if (reset)
      q <= 32'b1;
    else
      q <= next_q;
  end

endmodule
