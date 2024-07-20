module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);

  reg [7:0] d_lower;
  reg [7:0] d_upper;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      d_lower <= 0;
      d_upper <= 0;
    end else begin
      if (byteena[0])
        d_lower <= d[7:0];
      if (byteena[1])
        d_upper <= d[15:8];
    end
  end
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      q <= 0;
    else begin
      if (byteena[0])
        q[7:0] <= d_lower;
      if (byteena[1])
        q[15:8] <= d_upper;
    end
  end

endmodule
