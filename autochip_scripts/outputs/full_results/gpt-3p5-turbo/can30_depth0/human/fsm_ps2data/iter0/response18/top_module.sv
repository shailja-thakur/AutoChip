module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] message;
	reg [1:0] state;
	assign done = (state == 2'b11);
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00;
			message <= 24'b0;
		end else begin
			case (state)
				2'b00: begin
					if (in[3])
						state <= 2'b01;
				end
				2'b01: begin
					state <= 2'b10;
					message[23:16] <= in;
				end				
				2'b10: begin
					state <= 2'b11;
					message[15:8] <= in;
				end				
				2'b11: begin
					state <= 2'b00;
					message[7:0] <= in;
				end
				default: state <= 2'b00;
			endcase
		end
	end
	
	assign out_bytes = (state == 2'b11) ? message : 24'b0;
	
endmodule
