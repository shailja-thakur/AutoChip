module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg [3:0] next_state;
	assign disc = (state == 3'b001);
	assign flag = (state == 3'b010);
	assign err = (state == 3'b011);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	always @(state or in) begin
		case (state)
			3'b000: begin
						if (in) begin 
							next_state = 3'b001;
						end else begin 
							next_state = 3'b000;
						end
					end
			3'b001: begin
						if (in) begin 
							next_state = 3'b010;
						end else begin 
							next_state = 3'b100;
						end
					end
			3'b010: begin
						if (in) begin 
							next_state = 3'b011;
						end else begin 
							next_state = 3'b100;
						end
					end
			3'b011: next_state = 3'b000;
			3'b100: begin
						if (in) begin 
							next_state = 3'b101;
						end else begin 
							next_state = 3'b110;
						end
					end
			3'b101: next_state = 3'b000;
			3'b110: next_state = 3'b000;
			default: next_state = 3'b000;
		endcase
	end

endmodule
