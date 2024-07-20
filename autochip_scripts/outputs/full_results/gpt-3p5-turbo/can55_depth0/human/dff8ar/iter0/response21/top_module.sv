module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);

  reg [7:0] q_next;  // Intermediate signal for storing next state of q

  always @(posedge clk or posedge areset) begin
    if (areset)
      q_next <= 8'b00000000;
    else
      q_next <= d;
  end

  always @(posedge clk) begin
    q <= q_next;
  end
  
endmodule
