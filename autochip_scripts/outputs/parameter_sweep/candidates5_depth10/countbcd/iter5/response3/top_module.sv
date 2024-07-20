module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 0;
    end else begin
      q <= q + 1;
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      ena <= 0;
    end else begin
      ena <= {q[7], q[11], q[15]};
    end
  end
  
endmodule
