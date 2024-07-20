module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

// internal signals
wire [4:0] not_a = ~a;
wire [4:0] not_b = ~b;
wire [4:0] not_c = ~c;
wire [4:0] not_d = ~d;
wire [4:0] not_e = ~e;

// assign output
assign out = {not_a, not_a, not_a, not_a, not_a, not_b, not_b, not_b, not_b, not_b,
             not_c, not_c, not_c, not_c, not_c, not_d, not_d, not_d, not_d, not_d,
             not_e, not_e, not_e, not_e, not_e} ^ {a, a, a, a, a, b, b, b, b, b,
                                                 c, c, c, c, c, d, d, d, d, d,
                                                 e, e, e, e, e};

endmodule
