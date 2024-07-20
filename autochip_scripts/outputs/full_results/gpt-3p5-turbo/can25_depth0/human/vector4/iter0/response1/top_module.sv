module top_module (
	input [7:0] in,
	output [31:0] out
);

wire [7:0] sign_ext;
wire [31:8] replication;
wire [31:0] concatenation;

assign sign_ext = {24{in[7]}};
assign replication = {sign_ext, in};
assign concatenation = replication;

assign out = concatenation;

endmodule
