module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	
	// Create enumeration for state
	typedef enum logic [2:0] {
		IDLE,
		START,
		DATA,
		STOP
	} state_t;
	
	reg state;
	reg [7:0] data;
	reg stop_bit;
	reg done;
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data <= 0;
			stop_bit <= 0;
			done <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (in == 1'b0) begin
						state <= START;
						data <= 0;
					end
				end
				
				START: begin
					if (in == 1'b0) begin
						state <= DATA;
						data <= 0;
					end else begin
						state <= IDLE;
					end
				end
				
				DATA: begin
					if (in == 1'b0) begin
						data <= {data[6:0], in};
						if (data[7] == 1) begin
							state <= STOP;
						end
					end else begin
						state <= IDLE;
					end
				end
				
				STOP: begin
					if (in == 1'b1) begin
						stop_bit <= in;
						if (stop_bit == 1) begin
							done <= 1;
						end
						state <= IDLE;
					end
				end
			endcase
		end
	end
	
endmodule
