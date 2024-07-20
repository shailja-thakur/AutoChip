module top_module(
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q);
  
  // always block triggered on positive edge of clk and areset
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      q <= 8'h0;
    end else begin
      q <= d;
    end
  end
  
endmodule
