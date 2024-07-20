module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state, next_state;

	parameter S_IDLE = 3'b000;
	parameter S_1 = 3'b001;
	parameter S_2 = 3'b010;
	parameter S_3 = 3'b011;
	parameter S_ERR = 3'b100;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S_IDLE;
		end else begin
			state <= next_state;
		end
	end

	always @(state or in) begin
		case(state)
			S_IDLE: begin
				if (in == 1'b0) begin
					next_state = S_IDLE;
				end else begin
					next_state = S_1;
				end
			end
			S_1: begin
				if (in == 1'b0) begin
					next_state = S_IDLE;
				end else if (in == 1'b1) begin
					next_state = S_2;
				end
			end
			S_2: begin
				if (in == 1'b0) begin
					next_state = S_IDLE;
				end else if (in == 1'b1) begin
					next_state = S_3;
				end
			end
			S_3: begin
				if (in == 1'b0) begin
					next_state = S_IDLE;
				end else if (in == 1'b1) begin
					next_state = S_ERR;
				end
			end
			S_ERR: begin
				if (in == 1'b0) begin
					next_state = S_IDLE;
				end else begin
					next_state = S_ERR;
				end
			end
		endcase
	end

	always @(state) begin
		case(state)
			S_IDLE: begin
				disc = 1'b0;
				flag = 1'b0;
				err = 1'b0;
			end
			S_1: begin
				disc = 1'b0;
				flag = 1'b0;
				err = 1'b0;
			end
			S_2: begin
				disc = 1'b0;
				flag = 1'b0;
				err = 1'b0;
			end
			S_3: begin
				disc = 1'b0;
				flag = 1'b1;
				err = 1'b0;
			end
			S_ERR: begin
				disc = 1'b1;
				flag = 1'b0;
				err = 1'b1;
			end
		endcase
	end
	
endmodule
