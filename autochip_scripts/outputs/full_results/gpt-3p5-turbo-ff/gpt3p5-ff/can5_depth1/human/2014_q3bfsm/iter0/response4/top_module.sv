module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// Declare state register
	reg [2:0] present_state, next_state;

	// Declare output wire
	wire output_z;

	// Assign present state based on reset signal
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			present_state <= 3'b000;
		end else begin
			present_state <= next_state;
		end
	end

	// Assign next state and output based on present state and input
	always @(present_state or x) begin
		case (present_state)
			3'b000: begin
				if (x == 1'b0) begin
					next_state = 3'b000;
					z = 1'b0;
				end else begin
					next_state = 3'b001;
					z = 1'b0;
				end
			end
			3'b001: begin
				if (x == 1'b0) begin
					next_state = 3'b001;
					z = 1'b0;
				end else begin
					next_state = 3'b100;
					z = 1'b0;
				end
			end
			3'b010: begin
				if (x == 1'b0) begin
					next_state = 3'b010;
					z = 1'b0;
				end else begin
					next_state = 3'b001;
					z = 1'b0;
				end
			end
			3'b011: begin
				if (x == 1'b0) begin
					next_state = 3'b001;
					z = 1'b1;
				end else begin
					next_state = 3'b010;
					z = 1'b1;
				end
			end
			3'b100: begin
				if (x == 1'b0) begin
					next_state = 3'b011;
					z = 1'b1;
				end else begin
					next_state = 3'b100;
					z = 1'b1;
				end
			end
			default: begin
				next_state = 3'b000;
				z = 1'b0;
			end
		endcase
	end

endmodule
