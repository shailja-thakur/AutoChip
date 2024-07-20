module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q[0] <= data[1] ^ 0;
      q[511] <= 0 ^ data[510];
      for (int i = 1; i < 511; i=i+1) begin
        q[i] <= q[i-1] ^ q[i+1];
      end
    end
  end
endmodule
