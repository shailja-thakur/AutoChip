module top_module (
	input [7:0] in,
	output [31:0] out
);
  reg [31:0] sign_ext;

  always @(in) begin
    // Sign-extend the input to 32 bits
    sign_ext = {24 {in[7]}, in};
  end

  assign out = sign_ext;

endmodule
