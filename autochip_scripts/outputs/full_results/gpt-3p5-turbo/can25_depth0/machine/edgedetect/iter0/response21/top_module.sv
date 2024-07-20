module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

  reg [7:0] d_last; // register to store previous value of in

  always @(posedge clk) begin
    d_last <= in; // store current value of in in d_last register
    pedge <= in & ~d_last; // calculate pedge using bitwise AND operation
  end

endmodule
