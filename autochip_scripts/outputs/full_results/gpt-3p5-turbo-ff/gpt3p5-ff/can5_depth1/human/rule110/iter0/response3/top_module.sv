module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  reg [511:0] temp;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      temp[511] <= (q[510] & q[511]) | (q[511] & q[510]) |
                   (q[510] & ~q[509]) | (~q[510] & ~q[509]);
      temp[510:0] <= q[511:1];
      q <= temp;
    end
  end

endmodule
