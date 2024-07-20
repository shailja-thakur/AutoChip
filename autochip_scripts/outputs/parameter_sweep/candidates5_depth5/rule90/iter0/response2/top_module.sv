module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q[0] = data[511] ^ data[0] ^ data[1];
      for (int i = 1; i < 511; i = i + 1) begin
        q[i] = data[i - 1] ^ data[i] ^ data[i + 1];
      end
      q[511] = data[510] ^ data[511] ^ 0;
    end
  end

endmodule
