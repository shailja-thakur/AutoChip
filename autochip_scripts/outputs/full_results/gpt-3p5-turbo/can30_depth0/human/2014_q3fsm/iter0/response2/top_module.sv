module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	reg [1:0] state;
	reg [1:0] next_state;

	parameter A = 2'b00;
	parameter B = 2'b01;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	always @* begin
		next_state = state;
		case (state)
			A: begin
				if (s == 1)
					next_state = B;
			end
			B: begin
				if (w == 0)
					next_state = A;
				else if (w == 1)
					next_state = B;
			end
		endcase
	end

	always @(posedge clk) begin
		case (state)
			A: begin
				if (s == 0)
					z <= 0;
			end
			B: begin
				if (w == 1 && count_ones(w, clk) == 2)
					z <= 1;
				else
					z <= 0;
			end
		endcase
	end

	function count_ones(input_word, input_clk);
		reg [2:0] counter;
		always @(posedge input_clk) begin
			counter <= counter + input_word;
		end
		count_ones = counter;
	endfunction

endmodule
