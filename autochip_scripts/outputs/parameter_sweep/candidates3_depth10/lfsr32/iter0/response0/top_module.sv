module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

  reg [31:0] shift_register;
  wire next_bit;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shift_register <= 32'b0;
      q <= 32'h1;
    end else begin
      shift_register <= {next_bit, shift_register[31:1]};
      q <= shift_register;
    end
  end

  xor gate_1(next_bit, shift_register[0], shift_register[21], shift_register[31]);
  xor gate_2(next_bit, shift_register[0], shift_register[31]);
  xor gate_3(next_bit, shift_register[0], shift_register[1], shift_register[21], shift_register[31]);

endmodule
