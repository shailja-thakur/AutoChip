module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
  
  wire [24:0] not_a, not_b, not_c, not_d, not_e;
  assign not_a = ~a;
  assign not_b = ~b;
  assign not_c = ~c;
  assign not_d = ~d;
  assign not_e = ~e;

  wire [4:0] concat_a, concat_b, concat_c, concat_d, concat_e;
  assign concat_a = {5{a}};
  assign concat_b = {5{b}};
  assign concat_c = {5{c}};
  assign concat_d = {5{d}};
  assign concat_e = {5{e}};

  assign out = not_a ^ concat_a ^ not_b ^ concat_b ^ not_c ^ concat_c ^ not_d ^ concat_d ^ not_e ^ concat_e;
  
endmodule
