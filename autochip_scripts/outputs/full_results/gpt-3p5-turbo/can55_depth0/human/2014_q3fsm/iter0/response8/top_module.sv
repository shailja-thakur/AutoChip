module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
	
	// Define states
	enum logic [1:0] state;
	parameter A = 2'b00;
	parameter B = 2'b01;
	
	// Define internal signals
	reg [1:0] w_history;
	
	// Initialize signals and registers
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A; // reset state
			z <= 0; // reset output
			w_history <= 0; // reset w history
		end else begin
			case (state)
				A: begin
					if (s) begin
						state <= B;
						w_history <= 0;
					end
				end
				B: begin
					if (w) begin
						w_history <= w_history + 1;
						if (w_history == 2'b11) begin
							z <= 1;
						end else begin
							z <= 0;
						end
					end
					if (w_history >= 2) begin
						w_history <= 0;
					end
				end
			endcase
		end
	end
	
endmodule
