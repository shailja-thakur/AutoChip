module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  reg [511:0] next_q;

  always @(posedge clk) begin
    if (load)
      q <= data;
    else begin
      for (integer i = 0; i < 512; i = i + 1)
        next_q[i] <= q[i];
      for (integer i = 0; i < 512; i = i + 1) begin
        if (i == 0)
          q[i] <= (q[i] & q[i + 1]);
        else if (i == 511)
          q[i] <= (q[i] & q[i - 1]);
        else
          q[i] <= (q[i - 1] ^ (q[i] ^ q[i + 1]));
      end
    end
  end
  
endmodule
