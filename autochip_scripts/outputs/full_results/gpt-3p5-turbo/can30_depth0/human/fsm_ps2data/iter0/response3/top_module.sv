module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	// Internal signals
	reg [2:0] state;
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;
	reg [23:0] message;
	reg done_reg;	
	
	// State definitions
	parameter IDLE_STATE = 3'b000;
	parameter SEARCHING_STATE = 3'b001;
	parameter BYTE1_RECEIVED_STATE = 3'b010;
	parameter BYTE2_RECEIVED_STATE = 3'b011;
	parameter BYTE3_RECEIVED_STATE = 3'b100;
	
	// Initial state assignment
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE_STATE;
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
			message <= 24'b0;
			done_reg <= 1'b0;
		end else begin
			case(state)
				IDLE_STATE: begin
					if (in[3] == 1'b1) begin
						state <= SEARCHING_STATE;
					end
				end
				SEARCHING_STATE: begin
					if (in[3] == 1'b1) begin
						state <= BYTE1_RECEIVED_STATE;
						byte1 <= in;
					end
				end
				BYTE1_RECEIVED_STATE: begin
					state <= BYTE2_RECEIVED_STATE;
					byte2 <= in;
				end
				BYTE2_RECEIVED_STATE: begin
					state <= BYTE3_RECEIVED_STATE;
					byte3 <= in;
				end
				BYTE3_RECEIVED_STATE: begin
					state <= SEARCHING_STATE;
					message <= {byte1, byte2, byte3};
					byte1 <= 8'b0;
					byte2 <= 8'b0;
					byte3 <= 8'b0;
					done_reg <= 1'b1;				
				end
				default: state <= IDLE_STATE;
			endcase
		end
	end
	
	// Assign output values
	assign out_bytes = done_reg ? message : 24'b0;
	assign done = done_reg;
	
endmodule
