module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
  
  reg [511:0] tmp_q;
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      tmp_q = q;
      q[0] = (tmp_q[1] & tmp_q[0] & ~tmp_q[512]) | (~tmp_q[1] & tmp_q[0] & tmp_q[512]) | (tmp_q[1] & ~tmp_q[0] & tmp_q[512]) | (~tmp_q[1] & ~tmp_q[0] & ~tmp_q[512]);
      
      for (int i = 1; i < 511; i = i + 1) begin
        q[i] = (tmp_q[i+1] & tmp_q[i] & tmp_q[i-1]) | (~tmp_q[i+1] & tmp_q[i] & ~tmp_q[i-1]) | (tmp_q[i+1] & ~tmp_q[i] & ~tmp_q[i-1]) | (~tmp_q[i+1] & ~tmp_q[i] & tmp_q[i-1]);
      end
      
      q[511] = (tmp_q[511+1] & tmp_q[511] & ~tmp_q[510]) | (~tmp_q[511+1] & tmp_q[511] & ~tmp_q[510]) | (tmp_q[511+1] & ~tmp_q[511] & tmp_q[510]) | (~tmp_q[511+1] & ~tmp_q[511] & tmp_q[510]);
    end
  end
endmodule
