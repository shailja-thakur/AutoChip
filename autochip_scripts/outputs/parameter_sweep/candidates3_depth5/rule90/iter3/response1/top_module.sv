module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  reg [511:0] temp;

  always @(posedge clk) begin
    if(load)
      q <= data;
    else begin
      temp[0] <= (~q[511]) & q[0] & q[1];
      temp[511] <= q[510] & q[511] & (~q[0]);
      for(int i=1; i<511; i=i+1)
        temp[i] <= q[i-1] ^ q[i+1];
        
      q <= temp;
    end
  end

endmodule
