module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

  reg [511:0] next_q;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      next_q[0] <= 0;
      for (int i=1; i<511; i=i+1) begin
        if (i == 510)
          next_q[i] <= ((q[i-1] & q[i] & ~q[0]) | (~q[i-1] & ~q[i] & q[0]));
        else
          next_q[i] <= ((q[i+1] & ((q[i] & ~q[i-1]) | (~q[i] & q[i-1]))) | ((~q[i+1] & ((~q[i] & q[i-1]) | (q[i] & ~q[i-1])))));
      end
      next_q[511] <= 0;
      
      q <= next_q;
    end
  end
endmodule
