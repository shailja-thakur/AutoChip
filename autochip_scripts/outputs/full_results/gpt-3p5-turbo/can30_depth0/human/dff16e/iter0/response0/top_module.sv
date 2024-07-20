module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);
  
  reg [15:0] q_var;

  always @(posedge clk or negedge resetn) begin
    if (~resetn)
      q_var <= 16'b0;
    else if (byteena[1])
      q_var[15:8] <= d[15:8];
    else if (byteena[0])
      q_var[7:0] <= d[7:0];
  end

  // Output register
  always @(posedge clk) begin
    q <= q_var;
  end
endmodule
