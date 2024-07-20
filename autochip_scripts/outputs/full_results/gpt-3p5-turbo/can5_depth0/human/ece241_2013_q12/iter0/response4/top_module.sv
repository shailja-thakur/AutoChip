module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

reg [7:0] Q;
wire [7:0] MUX_inputs;

D_FF DFF0(.D(S), .clk(clk), .enable(enable), .Q(Q[0]));
D_FF DFF1(.D(Q[0]), .clk(clk), .enable(enable), .Q(Q[1]));
D_FF DFF2(.D(Q[1]), .clk(clk), .enable(enable), .Q(Q[2]));
D_FF DFF3(.D(Q[2]), .clk(clk), .enable(enable), .Q(Q[3]));
D_FF DFF4(.D(Q[3]), .clk(clk), .enable(enable), .Q(Q[4]));
D_FF DFF5(.D(Q[4]), .clk(clk), .enable(enable), .Q(Q[5]));
D_FF DFF6(.D(Q[5]), .clk(clk), .enable(enable), .Q(Q[6]));
D_FF DFF7(.D(Q[6]), .clk(clk), .enable(enable), .Q(Q[7]));

assign MUX_inputs[0] = Q[0];
assign MUX_inputs[1] = Q[1];
assign MUX_inputs[2] = Q[2];
assign MUX_inputs[3] = Q[3];
assign MUX_inputs[4] = Q[4];
assign MUX_inputs[5] = Q[5];
assign MUX_inputs[6] = Q[6];
assign MUX_inputs[7] = Q[7];

always @(A or B or C)
begin
	case({A,B,C})
		3'b000: Z = MUX_inputs[0];
		3'b001: Z = MUX_inputs[1];
		3'b010: Z = MUX_inputs[2];
		3'b011: Z = MUX_inputs[3];
		3'b100: Z = MUX_inputs[4];
		3'b101: Z = MUX_inputs[5];
		3'b110: Z = MUX_inputs[6];
		3'b111: Z = MUX_inputs[7];
	endcase
end

endmodule
module D_FF (
	input D,
	input clk,
	input enable,
	output reg Q
);

always @(posedge clk)
begin
	if (enable)
		Q <= D;
end

endmodule
