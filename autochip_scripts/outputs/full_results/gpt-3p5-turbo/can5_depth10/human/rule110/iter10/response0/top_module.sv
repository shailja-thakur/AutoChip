module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q[0] <= 0;
      for (int i=1; i<512; i=i+1) begin
        if (i == 1) // Corrected index
          q[i] <= ((q[i-1] & q[i] & ~q[i+1]) | (~q[i-1] & ~q[i] & q[i+1]));
        else if (i == 511)
          q[i] <= ((q[i-1] & q[i] & ~q[i+1]) | (~q[i-1] & ~q[i] & q[i+1]));
        else
          q[i] <= ((q[i-1] & q[i] & ~q[i+1]) | (~q[i-1] & ~q[i] & q[i+1]));
      end
    end
  end
endmodule
