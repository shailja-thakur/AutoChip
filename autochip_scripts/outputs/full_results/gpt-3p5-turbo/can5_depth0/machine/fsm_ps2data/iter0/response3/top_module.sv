module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [7:0] reg_in;
reg [23:0] reg_out;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
		reg_in <= 8'b0;
		reg_out <= 24'b0;
		done <= 1'b0;
	end else begin
		case (state)
			BYTE1: begin
				reg_in <= {reg_in[6:0], in[7]};
				reg_out <= {reg_in, reg_out[23:8]};
				if (in[2]) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end
			
			BYTE2: begin
				reg_in <= {reg_in[6:0], in[7]};
				reg_out <= {reg_in, reg_out[23:8]};
				state <= BYTE3;
			end
			
			BYTE3: begin
				reg_in <= {reg_in[6:0], in[7]};
				reg_out <= {reg_in, reg_out[23:8]};
				state <= DONE;
			end
			
			DONE: begin
				reg_in <= {reg_in[6:0], in[7]};
				reg_out <= {reg_in, reg_out[23:8]};
				state <= BYTE1;
			end
		endcase
		
		if (state == DONE) begin
			done <= 1'b1;
		end else begin
			done <= 1'b0;
		end
	end
end

assign out_bytes = reg_out;

endmodule
