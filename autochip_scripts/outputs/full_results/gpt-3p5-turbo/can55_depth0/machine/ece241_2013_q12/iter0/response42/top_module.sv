module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

// Define the register
reg [7:0] q;

// Multiplexer select input
wire [2:0] mux_sel;

// Assign the mux select input based on the A, B, and C inputs
assign mux_sel = {A, B, C};

// Register enable and shift logic
always @(posedge clk) begin
	if (enable) begin
		q <= {q[6:0], S};
	end
end

// Output multiplexer logic
always @(mux_sel or q) begin
	case(mux_sel)
		3'b000: Z <= q[0];
		3'b001: Z <= q[1];
		3'b010: Z <= q[2];
		3'b011: Z <= q[3];
		3'b100: Z <= q[4];
		3'b101: Z <= q[5];
		3'b110: Z <= q[6];
		3'b111: Z <= q[7];
	endcase
end

endmodule
