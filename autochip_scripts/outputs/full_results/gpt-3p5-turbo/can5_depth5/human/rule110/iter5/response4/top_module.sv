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
      
      q_next[0] = (q[1] & q[0]) | (~q[1] & (~(q[1] | data[0])));
      q_next[511] = (~q[510] & (~(data[510] | q[510])));
      
      for (integer i = 1; i < 511; i = i + 1) begin
        q_next[i] = (q[i-1] & (~((q[i-1] & q[i+1])))) | (~q[i-1] & (((q[i-1] | q[i+1]) & (~(data[i-1] & data[i+1])))));
      end
      
      q <= q_next;
    end
  end
endmodule
