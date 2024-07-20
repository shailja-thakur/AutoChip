module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [23:0] received_bytes;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		received_bytes <= 0;
	end else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					state <= 1;
					received_bytes <= {in[7:0], received_bytes[23:8]};
				end
			end
			1: begin
				state <= 2;
				received_bytes <= {in[7:0], received_bytes[15:0]};
			end
			2: begin
				state <= 3;
				received_bytes <= {in[7:0], received_bytes[7:0]};
			end
			3: begin
				state <= 0;
				received_bytes <= {in[7:0], 0};
			end
			default: begin
				state <= 0;
				received_bytes <= 0;
			end
		endcase
	end
end

assign out_bytes = received_bytes;

assign done = (state == 3);

endmodule
