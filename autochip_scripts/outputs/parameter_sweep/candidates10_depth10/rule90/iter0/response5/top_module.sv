module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

always @(posedge clk) begin
  if (load)
    q <= data;
  else begin
    q[0]    <= data[1] ^ data[0] ^ 0;
    q[511]  <= 0 ^ data[511] ^ data[510];
    for (i = 1; i < 511; i = i + 1)
      q[i] <= data[i + 1] ^ data[i] ^ data[i - 1];
  end
end

endmodule
