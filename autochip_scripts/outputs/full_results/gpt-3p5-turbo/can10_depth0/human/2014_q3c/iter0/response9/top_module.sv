module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] Y;

	always @(posedge clk) begin
		case({y, x})
			3'b000: begin	// y=000, x=0
				Y <= 3'b000;
				Y0 <= Y[0];
				z <= 1'b0;
			end
			3'b000: begin	// y=000, x=1
				Y <= 3'b001;
				Y0 <= Y[0];
				z <= 1'b0;
			end
			3'b001: begin	// y=001, x=0
				Y <= 3'b001;
				Y0 <= Y[0];
				z <= 1'b0;
			end
			3'b001: begin	// y=001, x=1
				Y <= 3'b100;
				Y0 <= Y[0];
				z <= 1'b0;
			end
			3'b010: begin	// y=010, x=0
				Y <= 3'b010;
				Y0 <= Y[0];
				z <= 1'b0;
			end
			3'b010: begin	// y=010, x=1
				Y <= 3'b001;
				Y0 <= Y[0];
				z <= 1'b0;
			end
			3'b011: begin	// y=011, x=0
				Y <= 3'b001;
				Y0 <= Y[0];
				z <= 1'b1;
			end
			3'b011: begin	// y=011, x=1
				Y <= 3'b010;
				Y0 <= Y[0];
				z <= 1'b1;
			end
			3'b100: begin	// y=100, x=0
				Y <= 3'b011;
				Y0 <= Y[0];
				z <= 1'b1;
			end
			3'b100: begin	// y=100, x=1
				Y <= 3'b100;
				Y0 <= Y[0];
				z <= 1'b1;
			end
			default: begin
				Y <= 3'bxxx;
				Y0 <= Y[0];	// Placeholder value, update with desired default value
				z <= 1'bx;	// Placeholder value, update with desired default value
			end
		endcase
	end
endmodule
