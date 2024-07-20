module top_module(
  input clk,
  input [7:0] d,
  output reg [7:0] q);

  reg [7:0] register;

  always @(posedge clk) begin
    register <= d;
  end

  initial begin
    q = 8'b00000000;
  end

  assign q = register;
  
endmodule
