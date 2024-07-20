module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

// Define states
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Define state register
reg [1:0] state_reg;
// Define done signal
wire done;

// Define output register
reg [23:0] out_reg;
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= BYTE1;
		out_reg <= 0;
	end else begin
		case(state_reg)
			BYTE1: begin
				if (in[2] == 1) begin
					state_reg <= BYTE2;
				end else begin
					state_reg <= BYTE1;
				end
			end
			BYTE2: begin
				if (in[2] == 1) begin
					state_reg <= BYTE3;
				end else begin
					state_reg <= BYTE1;
				end
			end
			BYTE3: begin
				state_reg <= DONE;
			end
			DONE: begin
				if (in[2] == 1) begin
					state_reg <= BYTE1;
				end else begin
					state_reg <= BYTE1;
				end
			end
		endcase
		if (state_reg == DONE) begin
			done <= 1;
			out_reg <= out_reg;
		end else begin
			done <= 0;
			out_reg <= {out_reg[15:0], in};
		end
	end
end

assign out_bytes = out_reg;
assign done = done;

endmodule
