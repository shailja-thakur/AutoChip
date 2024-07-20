module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);

  reg [7:0] d_low;
  reg [7:0] d_high;

  always @(posedge clk or negedge resetn) begin
    if(!resetn)
      q <= 0;
    else begin
      if(byteena[0])
        d_low <= d[7:0];
      if(byteena[1])
        d_high <= d[15:8];
      q <= {(d_high[7:0], d_low[7:0])};
    end
  end

endmodule
