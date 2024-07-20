module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    wire [3:0] and_wire;
	assign out_and = and(and_wire);
	
	wire [3:0] or_wire;
	assign out_or = or(or_wire);
	
	wire [3:0] xor_wire;
	assign out_xor = xor(xor_wire);
	
    assign and_wire = in[0] & in[1] & in[2] & in[3];
    assign or_wire = in[0] | in[1] | in[2] | in[3];
    assign xor_wire = in[0] ^ in[1] ^ in[2] ^ in[3];
   
endmodule
