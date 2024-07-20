module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q[511] <= (q[510:510] & q[511:511])
              | (~q[510:510] & ~q[511:511]);

      for (int i = 510; i >= 1; i = i - 1) begin
        q[i] <= (q[i-1:i-1] & q[i:i])
              | (~q[i-1:i-1] & ~q[i:i] & q[i+1:i+1])
              | (~q[i-1:i-1] & q[i-1:i-1] & ~q[i:i] & q[i+1:i+1])
              | (~q[i-1:i-1] & q[i-1:i-1] & q[i:i] & q[i+1:i+1]);
      end

      q[0] <= (q[0:0] & q[1:1])
            | (~q[0:0] & ~q[1:1]);
    end
  end

endmodule
