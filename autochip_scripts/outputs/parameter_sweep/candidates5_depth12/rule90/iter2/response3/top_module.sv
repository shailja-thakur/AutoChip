module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

  always @(posedge clk) begin
    reg [511:0] temp_q;
    if (load) begin
      temp_q <= data;
    end else begin
      temp_q[0] = 0;
      temp_q[511] = 0;
      for (int i = 1; i < 511; i = i + 1) begin
        temp_q[i] <= q[i-1] ^ q[i+1];
      end
    end
    q <= temp_q;
  end
  
endmodule
