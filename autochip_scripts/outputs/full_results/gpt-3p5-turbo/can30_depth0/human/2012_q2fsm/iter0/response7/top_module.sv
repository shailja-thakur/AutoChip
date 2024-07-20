module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// declare variables
	reg [1:0] state, next_state;
	reg z;
	
	// state transition logic
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// state output logic
	always @(state, w) begin
		case (state)
			A: begin
				if (w) begin
					next_state =  B;
				end else begin
					next_state = A;
				end
				z = 0;
			end
			B: begin
				if (w) begin
					next_state =  C;
				end else begin
					next_state = D;
				end
				z = 0;
			end
			C: begin
				if (w) begin
					next_state =  E;
				end else begin
					next_state = D;
				end
				z = 0;
			end
			D: begin
				if (w) begin
					next_state =  F;
				end else begin
					next_state = A;
				end
				z = 0;
			end
			E: begin
				if (w) begin
					next_state =  E;
				end else begin
					next_state = D;
				end
				z = 1;
			end
			F: begin
				if (w) begin
					next_state =  C;
				end else begin
					next_state = D;
				end
				z = 1;
			end
			default: begin
				next_state = A;
				z = 0;
			end
		endcase
	end
	
endmodule
