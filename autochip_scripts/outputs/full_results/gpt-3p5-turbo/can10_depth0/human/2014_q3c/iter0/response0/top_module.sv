module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

// Declare registers to hold the next state values
reg [2:0] next_state_y;

// Assign next_state_y based on the current state y and input x
always @(posedge clk) begin
	case ({y, x})
		3'b0000: next_state_y = 3'b000;
		3'b0001: next_state_y = 3'b001;
		3'b0100: next_state_y = 3'b001;
		3'b0110: next_state_y = 3'b010;
		3'b1000: next_state_y = 3'b100;
		default: next_state_y = 3'b000;
	endcase
end

// Assign outputs Y0 and z based on the current state y and input x
always @(posedge clk) begin
	case ({y, x})
		3'b0000, 3'b0001: begin
			Y0 <= next_state_y[0];
			z <= 1'b0;
		end
		3'b0100: begin
			Y0 <= next_state_y[0];
			z <= 1'b0;
		end
		3'b0110: begin
			Y0 <= next_state_y[0];
			z <= 1'b1;
		end
		3'b1000: begin
			Y0 <= next_state_y[0];
			z <= 1'b1;
		end
		default: begin
			Y0 <= 1'b0;
			z <= 1'b0;
		end
	endcase
end

endmodule
