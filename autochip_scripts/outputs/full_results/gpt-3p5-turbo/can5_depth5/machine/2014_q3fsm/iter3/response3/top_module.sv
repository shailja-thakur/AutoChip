module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	reg [3:0] current_state;
	reg [3:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= 0;
		else
			current_state <= next_state;
	end
	
	always @(*) begin
		case (current_state)
			4'b0000: begin
				if (s)
					next_state = 4'b0001;
				else
					next_state = 4'b0100;
			end
			
			4'b0001, 4'b0010: begin
				if (w)
					next_state = 4'b0101;
				else
					next_state = 4'b0100;
			end
			
			4'b0011, 4'b0100, 4'b0110: begin
				if (w)
					next_state = 4'b1000;
				else
					next_state = 4'b0101;
			end
			
			4'b0111: begin
				next_state = 4'b0001;
			end
			
			4'b1000: begin
				if (w)
					next_state = 4'b0001;
				else
					next_state = 4'b0011;
			end
			
			4'b1001: begin
				if (w)
					next_state = 4'b0001;
				else
					next_state = 4'b0011;
			end
		endcase
	end
	
	always @(posedge clk) begin
		if (reset)
			z <= 0;
		else begin
			case (current_state)
				4'b0101, 4'b1011: begin
					z <= 1;
				end
				default: begin
					z <= 0;
				end
			endcase
		end
	end
endmodule
