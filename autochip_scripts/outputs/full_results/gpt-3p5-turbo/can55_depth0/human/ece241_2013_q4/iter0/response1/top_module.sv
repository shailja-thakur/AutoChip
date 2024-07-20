module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:0] state;
reg [2:0] prev_state;

// State Definitions
parameter ABOVE_S3 = 3'b000;
parameter BETWEEN_S3_S2 = 3'b001;
parameter BETWEEN_S2_S1 = 3'b010;
parameter BELOW_S1 = 3'b011;
parameter RESET_STATE = 3'b100;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= RESET_STATE;
		prev_state <= RESET_STATE;
	end
	else begin
		prev_state <= state;
		case (state)
			ABOVE_S3: begin
				if (s == 3'b111)
					state <= ABOVE_S3;
				else if (s == 3'b110)
					state <= BETWEEN_S3_S2;
				else if (s == 3'b100)
					state <= BELOW_S1;
				else
					state <= RESET_STATE;
			end
			
			BETWEEN_S3_S2: begin
				if (s == 3'b110)
					state <= BETWEEN_S3_S2;
				else if (s == 3'b100)
					state <= BELOW_S1;
				else if (s == 3'b000)
					state <= BETWEEN_S2_S1;
				else
					state <= RESET_STATE;
			end
			
			BETWEEN_S2_S1: begin
				if (s == 3'b100)
					state <= BELOW_S1;
				else if (s == 3'b000)
					state <= BETWEEN_S2_S1;
				else
					state <= RESET_STATE;
			end
			
			BELOW_S1: begin
				if (s == 3'b000)
					state <= BELOW_S1;
				else
					state <= RESET_STATE;
			end
			
			RESET_STATE: state <= RESET_STATE;
			
			default: state <= RESET_STATE;
		endcase
	end
end

always @(*) begin
	case (state)
		ABOVE_S3: begin
			fr3 = 1'b0;
			fr2 = 1'b0;
			fr1 = 1'b0;
			dfr = 1'b0;
		end
		
		BETWEEN_S3_S2: begin
			fr3 = 1'b0;
			fr2 = 1'b0;
			fr1 = 1'b1;
			dfr = 1'b0;
		end
		
		BETWEEN_S2_S1: begin
			fr3 = 1'b0;
			fr2 = 1'b1;
			fr1 = 1'b1;
			dfr = 1'b0;
		end
		
		BELOW_S1: begin
			fr3 = 1'b1;
			fr2 = 1'b1;
			fr1 = 1'b1;
			dfr = 1'b1;
		end
		
		RESET_STATE: begin
			fr3 = 1'b1;
			fr2 = 1'b1;
			fr1 = 1'b1;
			dfr = 1'b1;
		end
	endcase
end

endmodule
