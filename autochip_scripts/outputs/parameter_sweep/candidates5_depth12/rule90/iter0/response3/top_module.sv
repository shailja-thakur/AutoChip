module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
  
  reg [511:0] temp_q;
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      temp_q[0] = q[1] ^ q[511];
      temp_q[511] = q[510] ^ q[0];
      for (int i = 1; i < 511; i = i + 1) begin
        temp_q[i] = q[i-1] ^ q[i+1];
      end
      q <= temp_q;
    end
  end
  
endmodule
