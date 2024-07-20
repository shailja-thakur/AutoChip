module top_module(
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);

reg [63:0] shiftReg;

always @(posedge clk) begin
  if (load) begin
    shiftReg <= data;
  end else if (ena) begin
    case (amount)
      2'b00: shiftReg <= {shiftReg[62:0], shiftReg[63]};
      2'b01: shiftReg <= {shiftReg[55:0], shiftReg[63:56]};
      2'b10: shiftReg <= {shiftReg[0], shiftReg[63:1]};
      2'b11: shiftReg <= {shiftReg[7:0], shiftReg[63:8]};
    endcase
  end
end

assign q = shiftReg;

endmodule
