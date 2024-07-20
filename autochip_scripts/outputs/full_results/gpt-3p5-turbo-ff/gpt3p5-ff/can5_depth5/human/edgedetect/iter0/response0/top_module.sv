module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

  reg [7:0] in_previous;
  
  always @(posedge clk) begin
    in_previous <= in;
    
    pedge <= in & (~in_previous);
  end

endmodule
