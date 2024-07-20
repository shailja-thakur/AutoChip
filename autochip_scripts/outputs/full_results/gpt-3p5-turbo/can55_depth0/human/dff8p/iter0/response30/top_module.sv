module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);
  
  reg [7:0] q_reg [7:0];
  
  always @(negedge clk or posedge reset) begin
    if (reset) begin
      for (integer i = 0; i < 8; i = i+1) begin
        q_reg[i] <= 8'h34;
      end
    end else begin
      for (integer i = 0; i < 8; i = i+1) begin
        q_reg[i] <= d[i];
      end
    end
  end
  
  always @(posedge clk) begin
    for (integer i = 0; i < 8; i = i+1) begin
      q[i] <= q_reg[i];
    end
  end
  
endmodule
