module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

  reg [7:0] d_ff [0:7];
  
  always @(posedge clk or negedge reset) begin
    if (reset == 0) begin
      for (integer i = 0; i < 8; i = i + 1) begin
        d_ff[i] <= 8'h34;
      end
    end else begin
      for (integer i = 0; i < 8; i = i + 1) begin
        d_ff[i] <= d[i];
      end
    end
  end
  
  always @(negedge clk) begin
    for (integer i = 0; i < 8; i = i + 1) begin
      q[i] <= d_ff[i];
    end
  end
  
endmodule
