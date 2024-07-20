module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	
	reg [2:0] state;
	reg [23:0] register;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			register <= 24'b0;
		end else begin
			case(state)
				BYTE1:
					if (in[2]) begin
						register <= register << 8;
						register[7:0] <= in;
						state <= BYTE2;
					end else begin
						register <= register << 8;
						register[7:0] <= in;
						state <= BYTE1;
					end
				BYTE2:
					if (in[2]) begin
						register <= register << 8;
						register[7:0] <= in;
						state <= BYTE3;
					end else begin
						register <= register << 8;
						register[7:0] <= in;
						state <= BYTE1;
					end
				BYTE3:
					if (in[2]) begin
						register <= register << 8;
						register[7:0] <= in;
						state <= DONE;
					end else begin
						register <= register << 8;
						register[7:0] <= in;
						state <= BYTE1;
					end
				DONE:
					register <= register << 8;
					
					if (in[2]) begin
						register[7:0] <= in;
						state <= BYTE2;
					end else begin
						register[7:0] <= in;
						state <= BYTE1;
					end
			endcase
		end
	end
	
	assign out_bytes = done ? register : 24'b0;
	assign done = (state == DONE) ? 1'b1 : 1'b0;
	
endmodule
