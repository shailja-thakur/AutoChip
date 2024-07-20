module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);
	
	reg [3:0] state, next_state;
	
	// Define states
	localparam S0 = 4'b0000;
	localparam S1 = 4'b0001;
	localparam S2 = 4'b0010;
	localparam S3 = 4'b0011;
	localparam S4 = 4'b0100;
	localparam S5 = 4'b0101;
	localparam S6 = 4'b0110;
	localparam S7 = 4'b0111;
	localparam ERROR = 4'b1000;
	localparam DISCARD = 4'b1001;
	localparam FLAG = 4'b1010;
	
	// State transition logic
	always @(*) begin
		case (state)
			S0: next_state = in ? S1 : S0;
			S1: next_state = in ? S2 : S0;
			S2: next_state = in ? S3 : S0;
			S3: next_state = in ? S4 : S0;
			S4: next_state = in ? S5 : S0;
			S5: next_state = in ? S6 : (DISCARD);
			S6: next_state = in ? S7 : FLAG;
			S7: next_state = in ? ERROR : FLAG;
			DISCARD: next_state = in ? S1 : S0;
			FLAG: next_state = in ? S1 : S0;
			ERROR: next_state = ERROR;  // Remain in error state
			default: next_state = S0;
		endcase
	end
	
	// State register
	always @(posedge clk) begin
		if (reset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end
	
	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			disc <= 0;
			flag <= 0;
			err <= 0;
		end else begin
			disc <= (next_state == DISCARD);
			flag <= (next_state == FLAG);
			err <= (next_state == ERROR);
		end
	end
	
endmodule
