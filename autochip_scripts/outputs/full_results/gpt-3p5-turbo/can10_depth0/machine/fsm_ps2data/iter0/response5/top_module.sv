module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

// State Definitions
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Internal Signals
reg [1:0] state;
reg [23:0] reg_out_bytes;

// State Register
always @(posedge clk or posedge reset)
begin
	if (reset)
		state <= BYTE1;
	else
		begin
			case(state)
				BYTE1: if (in[2] == 1'b1)
							state <= BYTE2;
						else
							state <= BYTE1;
				BYTE2: if (in[2] == 1'b1)
							state <= BYTE3;
						else
							state <= BYTE2;
				BYTE3: if (in[2] == 1'b1)
							state <= DONE;
						else
							state <= BYTE3;
				DONE: if (in[2] == 1'b0)
							state <= BYTE1;
						else
							state <= DONE;
			endcase
		end
end

// Output Registers
always @(posedge clk)
begin
	if (state == DONE)
		begin
			reg_out_bytes <= reg_out_bytes << 8;
			reg_out_bytes[7:0] <= in;
		end
end

// Assign Outputs
assign out_bytes = reg_out_bytes;
assign done = (state == DONE);

endmodule
