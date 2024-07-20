module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// the current state of the FSM
reg [1:0] state;

// the output of the FSM
reg out;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= A;
		out <= 0;
	end
	else begin
		case(state)
			A: begin
				if (in) begin
					state <= B;
					out <= 0;
				end
				else begin 
					state <= A;
					out <= 0;
				end
			end

			B: begin
				if (in) begin
					state <= B;
					out <= 0;
				end
				else begin 
					state <= C;
					out <= 0;
				end
			end

			C: begin
				if (in) begin
					state <= D;
					out <= 0;
				end
				else begin 
					state <= A;
					out <= 0;
				end
			end

			D: begin
				if (in) begin
					state <= B;
					out <= 1;
				end
				else begin 
					state <= C;
					out <= 0;
				end
			end
		endcase
	end
end

endmodule
