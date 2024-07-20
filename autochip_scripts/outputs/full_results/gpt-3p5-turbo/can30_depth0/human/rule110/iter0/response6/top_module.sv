module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
  
  always @(posedge clk) begin
    if (load)
      q <= data;
    else begin
      q[511] <= (q[510] & q[511]) | (q[511] & ~q[510]);
      q[510:1] <= ((q[512:2] & q[510:0]) | (~q[512:2] & q[511:1]))[509:0];
      q[0] <= q[1] & q[0];
    end
  end
endmodule
