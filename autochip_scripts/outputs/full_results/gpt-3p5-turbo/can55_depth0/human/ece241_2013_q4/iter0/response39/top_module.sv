module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

// State variables
reg [1:0] state;

// Sensor change variables
reg [3:1] s_prev;

// Current water level variable
reg [3:1] water_level;

// Define the states
parameter IDLE = 2'b00;
parameter ABOVE_S3 = 2'b01;
parameter BETWEEN_S3_S2 = 2'b10;
parameter BETWEEN_S2_S1 = 2'b11;

// Nominal flow rate values
wire [3:1] nominal_flow_rate_values = {3'b000, 3'b001, 3'b010, 3'b011};

// Output default values and reset state
always @(posedge clk or posedge reset) begin
	if (reset) begin
		fr3 <= 0;
		fr2 <= 0;
		fr1 <= 0;
		dfr <= 0;
		state <= IDLE;
		s_prev <= 0;
		water_level <= 0;
	end
	else begin
		case (state)
			IDLE: begin
				fr3 <= 0;
				fr2 <= 0;
				fr1 <= 0;
				dfr <= 0;
				if (s == 0) begin
					state <= IDLE;
				end
				else begin
					state <= ABOVE_S3;
					s_prev <= s;
					water_level <= s;
				end
			end
			
			ABOVE_S3: begin
				fr3 <= 0;
				fr2 <= 0;
				fr1 <= 0;
				dfr <= 0;
				if (s[1]) begin
					state <= BETWEEN_S3_S2;
					s_prev <= s;
					water_level <= s;
				end
				else if (s == 0) begin
					state <= IDLE;
				end
			end
			
			BETWEEN_S3_S2: begin
				fr3 <= 0;
				fr2 <= 0;
				fr1 <= nominal_flow_rate_values[s];
				dfr <= 0;
				if (s[2]) begin
					state <= BETWEEN_S2_S1;
					s_prev <= s;
					water_level <= s;
				end
				else if (s == 0) begin
					state <= IDLE;
				end
			end
			
			BETWEEN_S2_S1: begin
				fr3 <= 0;
				fr2 <= nominal_flow_rate_values[s];
				fr1 <= nominal_flow_rate_values[s-1];
				
				// Check if previous level was lower
				if (s_prev < s) begin
					dfr <= 1;
				end
				else begin
					dfr <= 0;
				end
				
				if (s[3]) begin
					state <= ABOVE_S3;
				end
				else if (s == 0) begin
					state <= IDLE;
				end
				s_prev <= s;
				water_level <= s;
			end
		endcase
	end
end

endmodule
