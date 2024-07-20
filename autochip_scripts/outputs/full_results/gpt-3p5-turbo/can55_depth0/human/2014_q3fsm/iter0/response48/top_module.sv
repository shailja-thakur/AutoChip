module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	reg [1:0] state;
	reg [1:0] next_state;

	initial begin
		state = 2'b00;
		next_state = 2'b00;
	end
	
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			next_state <= 2'b00;
		end
		else begin
			state <= next_state;
			case (state)
				2'b00: begin
					if (s) begin
						next_state <= 2'b01;
					end
					else begin
						next_state <= 2'b00;
					end
				end
				2'b01: begin
					next_state <= 2'b10;
				end
				2'b10: begin
					next_state <= 2'b11;
				end
				2'b11: begin
					next_state <= 2'b00;
				end
				default: next_state <= 2'b00;
			endcase
		end
	end
	
	always @ (posedge clk) begin
		case (state)
			2'b00: begin
				z <= 0;
			end
			2'b01: begin
				z <= 0;
			end
			2'b10: begin
				if (w == 2'b10) begin
					z <= 1;
				end
				else begin
					z <= 0;
				end
			end
			2'b11: begin
				if (w == 2'b11) begin
					z <= 1;
				end
				else begin
					z <= 0;
				end
			end
			default: z <= 0;
		endcase
	end
endmodule
