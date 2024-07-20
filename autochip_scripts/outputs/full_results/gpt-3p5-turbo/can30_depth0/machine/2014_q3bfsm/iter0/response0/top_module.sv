module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
	// Internal state variables
	reg [2:0] state;

	// Assign initial state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b001;  // A
		end else begin
			case (state)
				3'b000: begin  // A
					if (x) begin
						state <= 3'b010;  // B
					end else begin
						state <= 3'b000;  // A
					end
				end
				3'b010: begin  // B
					if (x) begin
						state <= 3'b101;  // E
					end else begin
						state <= 3'b010;  // B
					end
				end
				3'b001: begin  // C
					if (x) begin
						state <= 3'b010;  // B
					end else begin
						state <= 3'b001;  // C
					end
				end
				3'b100: begin  // D
					if (x) begin
						state <= 3'b001;  // C
					end else begin
						state <= 3'b010;  // B
					end
				end
				3'b101: begin  // E
					if (x) begin
						state <= 3'b101;  // E
					end else begin
						state <= 3'b100;  // D
					end
				end
				default: state <= 3'b001;  // A (default state)
			endcase
		end
	end
	
	// Assign output based on state
	always @(posedge clk) begin
		case (state)
			3'b100, 3'b101: z <= 1'b1;  // D or E
			default: z <= 1'b0;  // Other states
		endcase
	end
endmodule
