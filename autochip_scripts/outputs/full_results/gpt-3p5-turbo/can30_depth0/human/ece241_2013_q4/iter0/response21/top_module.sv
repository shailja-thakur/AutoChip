module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

// Define states for the state machine
parameter [2:0] ABOVE_S3 = 3'b000;
parameter [2:0] BETWEEN_S3_S2 = 3'b001;
parameter [2:0] BETWEEN_S2_S1 = 3'b010;
parameter [2:0] BELOW_S1 = 3'b011;
parameter [2:0] RESET_STATE = 3'b100; // Reset state

// Define register to hold the current state
reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= RESET_STATE;
	end else begin
		case(state)
			RESET_STATE: begin
				state <= BELOW_S1; // Start in the below s[1] state
			end

			ABOVE_S3: begin
				if (s[3]) begin // If s[3] sensor is asserted
					state <= ABOVE_S3; // Stay in the above s[3] state
					fr3 <= 0; // No flow rate
				end else begin
					if (s[2]) begin // If s[2] sensor is asserted
						state <= BETWEEN_S3_S2; // Transition to the between s[3] and s[2] state
						fr3 <= 1; // fr1 flow rate
					end else if (s[1]) begin // If s[1] sensor is asserted
						state <= BETWEEN_S2_S1; // Transition to the between s[2] and s[1] state
						fr2 <= 1; // fr1 flow rate
						dfr <= 1; // Open supplemental flow valve
					end else begin
						state <= BELOW_S1; // Transition to the below s[1] state
						fr1 <= 1; // fr1 flow rate
						fr2 <= 1; // fr2 flow rate
						dfr <= 1; // Open supplemental flow valve
					end
				end
			end

			BETWEEN_S3_S2: begin
				if (s[2]) begin // If s[2] sensor is asserted
					state <= BETWEEN_S3_S2; // Stay in the between s[3] and s[2] state
					fr3 <= 1; // fr1 flow rate
				end else if (s[1]) begin // If s[1] sensor is asserted
					state <= BETWEEN_S2_S1; // Transition to the between s[2] and s[1] state
					fr2 <= 1; // fr1 flow rate
					dfr <= 1; // Open supplemental flow valve
				end else begin
					state <= BELOW_S1; // Transition to the below s[1] state
					fr1 <= 1; // fr1 flow rate
					fr2 <= 1; // fr2 flow rate
					dfr <= 1; // Open supplemental flow valve
				end
			end

			BETWEEN_S2_S1: begin
				if (s[1]) begin // If s[1] sensor is asserted
					state <= BETWEEN_S2_S1; // Stay in the between s[2] and s[1] state
					fr2 <= 1; // fr1 flow rate
					dfr <= 1; // Open supplemental flow valve
				end else begin
					state <= BELOW_S1; // Transition to the below s[1] state
					fr1 <= 1; // fr1 flow rate
					fr2 <= 1; // fr2 flow rate
					dfr <= 1; // Open supplemental flow valve
				end
			end

			BELOW_S1: begin
				if (!s[1]) begin // If s[1] sensor is not asserted
					state <= BELOW_S1; // Stay in the below s[1] state
					fr1 <= 1; // fr1 flow rate
					fr2 <= 1; // fr2 flow rate
					fr3 <= 1; // fr3 flow rate
					dfr <= 1; // Open supplemental flow valve
				end else begin
					state <= ABOVE_S3; // Transition to the above s[3] state
					fr1 <= 0; // No flow rate
					fr2 <= 0; // No flow rate
					fr3 <= 0; // No flow rate
					dfr <= 0; // Close supplemental flow valve
				end
			end
		endcase
	end
end

endmodule
