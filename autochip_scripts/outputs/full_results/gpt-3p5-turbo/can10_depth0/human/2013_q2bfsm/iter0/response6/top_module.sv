module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	reg f;
	reg g;
	reg [1:0] state, next_state;
	reg [2:0] x_register;
	wire reset;

	// FSM states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// State register
	always @(posedge clk, negedge resetn) begin
		if (~resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always @(state, x, y) begin
		case (state)
			A: begin
				if (~resetn) begin
					next_state = A;
				end else begin
					if (x_register == 3'b101) begin
						next_state = B;
					end else begin
						next_state = A;
					end
				end
			end
			
			B: begin
				if (~resetn) begin
					next_state = A;
				end else begin
					if (y) begin
						next_state = C;
					end else begin
						next_state = D;
					end
				end
			end
			
			C: begin
				if (~resetn) begin
					next_state = A;
				end else begin
					if (y) begin
						next_state = C;
					end else begin
						next_state = D;
					end
				end
			end
			
			D: begin
				if (~resetn) begin
					next_state = A;
				end else begin
					next_state = D;
				end
			end
		endcase
	end
	
	// Output logic
	always @(state) begin
		case (state)
			A: begin
				f = 0;
				g = 0;
			end
			
			B: begin
				f = 1;
			end
			
			C: begin
				f = 0;
				g = 1;
			end
			
			D: begin
				f = 0;
				g = 0;
			end
		endcase
	end
	
	// X input register
	always @(posedge clk, negedge resetn) begin
		if (~resetn) begin
			x_register <= 0;
		end else begin
			x_register <= {x_register[1:0], x};
		end
	end

	wire x_sequence;
	assign x_sequence = (x_register == 3'b101);
	
	// Reset signal
	assign reset = ~resetn;

endmodule
