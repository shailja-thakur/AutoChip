module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

// State declaration
typedef enum logic [2:0] {
	IDLE,
	ABOVE_S3,
	BETWEEN_S3_S2,
	BETWEEN_S2_S1,
	BELOW_S1
} state_t;

// State and next state variables
state_t current_state, next_state;

// Output variables
logic [3:0] assert_sensors;

// Default output values
initial begin
	fr3 = 1'b0;
	fr2 = 1'b0;
	fr1 = 1'b0;
	dfr = 1'b0;
end

// State registers
always @(posedge clk)
	if (reset) begin // Reset state machine
		current_state <= IDLE;
	end else begin
		current_state <= next_state;
	end

// State transition and output logic
always @(current_state, s, assert_sensors)
	case (current_state)
		IDLE: begin
			if (s[1] & ~s[2] & ~s[3]) begin
				next_state = ABOVE_S3;
				assert_sensors = 3'b111;
			end else if (s[1] & s[2] & ~s[3]) begin
				next_state = BETWEEN_S3_S2;
				assert_sensors = 3'b110;
			end else if (s[1] & ~s[2] & ~s[3]) begin
				next_state = BETWEEN_S2_S1;
				assert_sensors = 3'b100;
			end else if (~s[1] & ~s[2] & ~s[3]) begin
				next_state = BELOW_S1;
				assert_sensors = 3'b000;
			end else begin
				next_state = IDLE;
				assert_sensors = 3'b000;
			end
		end

		ABOVE_S3: begin
			next_state = IDLE;
			assert_sensors = 3'b000;
		end

		BETWEEN_S3_S2: begin
			if (s[1] & s[2] & ~s[3]) begin
				next_state = BETWEEN_S3_S2;
				assert_sensors = 3'b110;
			end else if (s[1] & ~s[2] & ~s[3]) begin
				next_state = BETWEEN_S2_S1;
				assert_sensors = 3'b100;
			end else if (~s[1] & ~s[2] & ~s[3]) begin
				next_state = BELOW_S1;
				assert_sensors = 3'b000;
			end else begin
				next_state = IDLE;
				assert_sensors = 3'b000;
			end
		end

		BETWEEN_S2_S1: begin
			if (s[1] & ~s[2] & ~s[3]) begin
				next_state = BETWEEN_S2_S1;
				assert_sensors = 3'b100;
			end else if (~s[1] & ~s[2] & ~s[3]) begin
				next_state = BELOW_S1;
				assert_sensors = 3'b000;
			end else begin
				next_state = IDLE;
				assert_sensors = 3'b000;
			end
		end

		BELOW_S1: begin
			if (~s[1] & ~s[2] & ~s[3]) begin
				next_state = BELOW_S1;
				assert_sensors = 3'b000;
			end else begin
				next_state = IDLE;
				assert_sensors = 3'b000;
			end
		end
	endcase

// Output assignment
always @(posedge clk)
	case (current_state)
		IDLE: begin
			// Reset all outputs
			fr3 <= 1'b0;
			fr2 <= 1'b0;
			fr1 <= 1'b0;
			dfr <= 1'b0;
		end

		ABOVE_S3: begin
			fr3 <= 1'b0;
			fr2 <= 1'b0;
			fr1 <= 1'b0;
			dfr <= 1'b0;
		end

		BETWEEN_S3_S2: begin
			case (assert_sensors)
				3'b110: begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
			endcase
		end

		BETWEEN_S2_S1: begin
			case (assert_sensors)
				3'b100: begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
			endcase
		end

		BELOW_S1: begin
			case (assert_sensors)
				3'b000: begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
				end
			endcase
		end
	endcase

endmodule
