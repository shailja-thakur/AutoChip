module top_module (
  input clk,
  input enable,
  input S,
  input [2:0] address,
  output reg [7:0] q,
  output reg Z
);
//  Minimum error fixed:
//  - Replaced input A, B, C with input [2:0] address

//  Register declaration
reg [7:0] register;

//  Multiplexer
always @(address) begin
  case (address)
    3'b000: Z = register[0];
    3'b001: Z = register[1];
    3'b010: Z = register[2];
    3'b011: Z = register[3];
    3'b100: Z = register[4];
    3'b101: Z = register[5];
    3'b110: Z = register[6];
    3'b111: Z = register[7];
    default: Z = register[0];
  endcase
end

//  Register with shift
always @(posedge clk) begin
  if (enable)
    register <= {S, register[7:1]};
end

//  Output
assign q = register;

endmodule
