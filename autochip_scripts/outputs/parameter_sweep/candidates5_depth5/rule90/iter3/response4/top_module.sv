module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q[511] <= q[510] ^ q[0];
      for (int i = 510; i > 0; i = i - 1) begin
        q[i] <= q[i-1] ^ q[i+1];
      end
      q[0] <= q[1] ^ q[511];
    end
  end

  initial begin
    // Initialize q with zeros
    q <= '0;
  end

endmodule
