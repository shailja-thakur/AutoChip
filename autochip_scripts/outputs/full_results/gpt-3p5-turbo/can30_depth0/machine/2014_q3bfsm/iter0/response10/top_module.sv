module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b001;
		end else begin
			state <= next_state;
		end
	end

	always @(state or x) begin
		case (state)
			3'b000: begin // State A
				if (x) begin
					next_state = 3'b010; // State B
				end else begin
					next_state = 3'b000; // State A
				end
			end
			3'b001: begin // State B
				if (x) begin
					next_state = 3'b100; // State E
				end else begin
					next_state = 3'b001; // State B
				end
			end
			3'b010: begin // State C
				if (x) begin
					next_state = 3'b010; // State B
				end else begin
					next_state = 3'b010; // State C
				end
			end
			3'b011: begin // State D
				if (x) begin
					next_state = 3'b010; // State C
				end else begin
					next_state = 3'b010; // State B
				end
			end
			3'b100: begin // State E
				if (x) begin
					next_state = 3'b100; // State E
				end else begin
					next_state = 3'b011; // State D
				end
			end
			default: begin
				next_state = 3'b001; // Default to State B
			end
		endcase
	end

	always @(state) begin
		if (state == 3'b100 || state == 3'b101) begin
			z <= 1'b1; // Output high when state is D or E
		end else begin
			z <= 1'b0;
		end
	end
	
endmodule
