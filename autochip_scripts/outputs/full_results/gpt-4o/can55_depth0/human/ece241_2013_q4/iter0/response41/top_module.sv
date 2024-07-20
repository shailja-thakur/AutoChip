module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	typedef enum reg [1:0] {
		ST_LOW = 2'b00,
		ST_MEDIUM_LOW = 2'b01,
		ST_MEDIUM_HIGH = 2'b10,
		ST_HIGH = 2'b11
	} state_t;

	state_t current_state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= ST_LOW;
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 1;
		end else begin
			current_state <= next_state;
		end
	end

	always @(*) begin
		// Defaults
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;

		case (current_state)
			ST_LOW: begin
				if (s == 3'b000) begin
					fr3 = 1;
					fr2 = 1;
					fr1 = 1;
				end else if (s == 3'b001) begin
					next_state = ST_MEDIUM_LOW;
					fr3 = 0;
					fr2 = 1;
					fr1 = 1;
					dfr = 0;
				end
			end
			ST_MEDIUM_LOW: begin
				if (s == 3'b001) begin
					fr2 = 1;
					fr1 = 1;
				end else if (s == 3'b011) begin
					next_state = ST_MEDIUM_HIGH;
					fr2 = 0;
					fr1 = 1;
					dfr = 1;
				end else if (s == 3'b000) begin
					next_state = ST_LOW;
					fr3 = 1;
					fr2 = 1;
					fr1 = 1;
				end
			end
			ST_MEDIUM_HIGH: begin
				if (s == 3'b011) begin
					fr1 = 1;
				end else if (s == 3'b111) begin
					next_state = ST_HIGH;
					fr1 = 0;
					dfr = 0;
				end else if (s == 3'b001) begin
					next_state = ST_MEDIUM_LOW;
					fr2 = 1;
					fr1 = 1;
				end
			end
			ST_HIGH: begin
				if (s == 3'b111) begin
					fr1 = 0;
				end else if (s == 3'b011) begin
					next_state = ST_MEDIUM_HIGH;
					fr1 = 1;
					dfr = 1;
				end
			end
		endcase
	end
endmodule
