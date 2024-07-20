module top_module(
  input clk,
  input [7:0] d,
  output reg [7:0] q
);
  
  reg [7:0] q_ff;
  
  always @(posedge clk) begin
    q_ff <= d;
  end
  
  assign q = q_ff;
  
endmodule
