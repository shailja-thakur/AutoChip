module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

wire [4:0] a_wire;
wire [4:0] b_wire;
wire [4:0] c_wire;
wire [4:0] d_wire;
wire [4:0] e_wire;

assign a_wire = 5'b11111 - {a,a,a,a,a};
assign b_wire = 5'b11111 - {b,b,b,b,b};
assign c_wire = 5'b11111 - {c,c,c,c,c};
assign d_wire = 5'b11111 - {d,d,d,d,d};
assign e_wire = 5'b11111 - {e,e,e,e,e};

assign out = {a_wire,b_wire,c_wire,d_wire,e_wire} ^ {a,b,c,d,e};

endmodule
