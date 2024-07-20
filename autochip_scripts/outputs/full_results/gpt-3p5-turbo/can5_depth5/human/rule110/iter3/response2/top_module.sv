module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      reg [511:0] q_next;
      
      // Set boundaries to 0
      q_next[0] = 0;
      q_next[511] = 0;
      
      // Calculate the next state for the inner cells
      for (integer i = 1; i < 511; i = i + 1) begin
        q_next[i] = (~q[i-1] & ~q[i] & ~q[i+1]) | (~q[i-1] & ~q[i] & q[i+1] & data[i+1]) |
                    (~q[i-1] & q[i] & ~q[i+1] & data[i-1]) | (~q[i-1] & q[i] & q[i+1]) |
                    (q[i-1] & ~q[i] & ~q[i+1] & data[i-1] & data[i+1]) | (q[i-1] & ~q[i] & q[i+1] & data[i+1]) |
                    (q[i-1] & q[i] & ~q[i+1] & data[i-1] & data[i+1]) | (q[i-1] & q[i] & q[i+1] & data[i+1]);
      end
      
      q <= q_next;
    end
  end
endmodule
