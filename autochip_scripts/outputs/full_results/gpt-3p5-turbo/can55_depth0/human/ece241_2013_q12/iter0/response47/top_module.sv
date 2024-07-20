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
reg [2:0] ABC;
wire [2:0] ABC_wire;
wire [7:0] mux_out;

DFF_8bit DFF_1( .clk(clk), .enable(enable), .data(S), .Q(Q) );

assign ABC_wire = {A, B, C};
assign mux_out = Q[ABC_wire];

assign Z = mux_out;

endmodule
module DFF_8bit (
	input clk,
	input enable,
	input data,
	output reg [7:0] Q
);

always @(posedge clk) begin
	if (enable) begin
		Q <= {Q[6:0], data};
	end
end
        
endmodule
