module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
	// state register
	reg [1:0] state;
	
	// next state register
	reg [1:0] next_state;

	// always block to update state and next_state
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 2'b00;	// set state to A
		end else begin
			state <= next_state;	// update state
		end
	end
	
	// case statement to determine next_state based on current state and r
	always @(state, r) begin
		case (state)
			0: begin	// state A
				case (r)
					3'b001: next_state = 2'b01;	// r[1] high = B
					3'b010: next_state = 2'b10;	// r[2] high = C
					3'b100: next_state = 2'b11;	// r[3] high = D
					default: next_state = 2'b00;	// none of the bits of r high = A
				endcase
			end
			1: begin	// state B
				next_state = (r[1]) ? 2'b01 : 2'b00;	// r[1] high = B, otherwise A
			end
			2: begin	// state C
				next_state = (r[2]) ? 2'b10 : 2'b00;	// r[2] high = C, otherwise A
			end
			3: begin	// state D
				next_state = (r[3]) ? 2'b11 : 2'b00;	// r[3] high = D, otherwise A
			end
		endcase
	end
	
	// assign g based on the current state
	always @(state) begin
		case (state)
			1: g = 3'b001;	// state B, g[1] high
			2: g = 3'b010;	// state C, g[2] high
			3: g = 3'b100;	// state D, g[3] high
			default: g = 3'b000;	// any other state, all bits low
		endcase
	end
endmodule
