module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

// Defining the internal signals
reg [2:0] Y;

always @(posedge clk) begin
	case ({x, y})	
		2'b00_000: begin
			Y <= 3'b000;
		end
		2'b00_001: begin
			Y <= 3'b001;
		end
		2'b01_000: begin
			Y <= 3'b010;
		end
		2'b01_001: begin
			Y <= 3'b001;
		end
		2'b10_000: begin
			Y <= 3'b011;
		end
		default: begin
			Y <= 3'b000;
		end
	endcase
end

assign Y0 = Y[0];
assign z = (Y == 3'b011 || Y == 3'b100) ? 1'b1 : 1'b0;

endmodule
