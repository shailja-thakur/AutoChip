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
			0: begin
				if (s)
					next_state = 1;
				else
					next_state = 5;
			end
			
			1: begin
				if (w)
					next_state = 2;
				else
					next_state = 3;
			end
			
			2: begin
				next_state = 1;
			end
			
			3: begin
				if (w)
					next_state = 4;
				else
					next_state = 1;
			end
			
			4: begin
				if (w)
					next_state = 5;
				else
					next_state = 6;
			end
			
			5: begin
				if (w)
					next_state = 6;
				else
					next_state = 1;
			end
			
			6: begin
				if (w)
					next_state = 1;
				else
					next_state = 3;
			end

            default: next_state = 0;
		endcase
	end

	always @(posedge clk) begin
		if (reset)
			z <= 0;
		else begin
			case (current_state)
				5, 6: z <= 1;
				default: z <= 0;
			endcase
		end
	end
endmodule
