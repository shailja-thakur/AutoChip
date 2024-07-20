module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define state enumeration
typedef enum logic [1:0] {A, B, C, D} state_type;
state_type current_state;

// Define next state logic
always_ff @(posedge clk) begin
	if (reset) begin
		current_state <= A;
	end else begin
		case (current_state)
			A: begin
				if (in) begin
					current_state <= B;
				end else begin
					current_state <= A;
				end
			end
			B: begin
				if (in) begin
					current_state <= B;
				end else begin
					current_state <= C;
				end
			end
			C: begin
				if (in) begin
					current_state <= D;
				end else begin
					current_state <= A;
				end
			end
			D: begin
				if (in) begin
					current_state <= B;
				end else begin
					current_state <= C;
				end
			end
			default: begin
				current_state <= A;
			end
		endcase
	end
end

// Define output logic
assign out = (current_state == D);

endmodule
