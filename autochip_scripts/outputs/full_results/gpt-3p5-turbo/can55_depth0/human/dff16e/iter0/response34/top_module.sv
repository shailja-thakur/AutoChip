module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);
  
  reg [7:0] d_lower;
  reg [7:0] d_upper;
  
  always @(posedge clk, negedge resetn) begin
    if (~resetn) begin
      d_lower <= 8'b0;
      d_upper <= 8'b0;
    end else begin
      if (byteena[0])
        d_lower <= d[7:0];
      if (byteena[1])
        d_upper <= d[15:8];
    end
  end
  
  always @(posedge clk) begin
    if (resetn)
      q <= {d_upper, d_lower};
  end
  
endmodule
