module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Define states
	typedef enum logic [3:0] {
		A,
		B,
		C,
		S10,
		S11,
		S20,
		S21,
		S22
	} state_type;
	
	// Declare and initialize state variable
	reg state_type current_state;
	
	initial begin
		current_state = A;    // Set initial state
	end
	
	// Always block for state transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
            current_state <= A;    // Reset state to A
        end else begin
            case (current_state)
                A: begin
                    if (s) begin
                        current_state <= B;
                    end
                end
                B, C: begin
                    if (w) begin
                        current_state <= S11;
                    end else begin
                        current_state <= S10;
                    end
                end
                S10: begin
                    if (w) begin
                        current_state <= S21;
                    end else begin
                        current_state <= S20;
                    end
                end
                S11: begin
                    if (w) begin
                        current_state <= S22;
                    end else begin
                        current_state <= S21;
                    end
                end
                S20: begin
                    current_state <= B;
                end
                S21: begin
                    if (w) begin
                        current_state <= C;
                    end else begin
                        current_state <= B;
                    end
                end
                S22: begin
                    if (w) begin
                        current_state <= B;
                    end else begin
                        current_state <= C;
                    end
                end
            endcase
        end
	end
	
	// Always block for output z
	always @(current_state) begin
		case (current_state)
			B, S11, S20: begin
				z <= 1;
			end
			default: begin
				z <= 0;
			end
		endcase
	end

endmodule
