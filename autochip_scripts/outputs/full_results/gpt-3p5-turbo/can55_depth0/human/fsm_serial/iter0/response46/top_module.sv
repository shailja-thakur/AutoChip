module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	reg [2:0] state;
	reg done;
	reg [7:0] data;
	// next state logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
				3'b000: begin
					if (in)
						state <= 3'b001;
					else
						state <= 3'b000;
				end
				3'b001: begin
					state <= 3'b010;
				end
				3'b010: begin
					state <= 3'b011;
				end
				3'b011: begin
					state <= 3'b100;
				end
				3'b100: begin
					state <= 3'b101;
				end
				3'b101: begin
					state <= 3'b110;
				end
				3'b110: begin
					state <= 3'b111;
				end
				3'b111: begin
					state <= 3'b000;
				end
			endcase
		end
	end
	
	// output logic
	always @(state) begin
		case (state)
			3'b000: begin
				done = 0;
			end
			3'b001: begin
				done = 0;
			end
			3'b010: begin
				done = 0;
				data = {data[6:0], in};
			end
			3'b011: begin
				done = 0;
				data = {data[6:0], in};
			end
			3'b100: begin
				done = 0;
				data = {data[6:0], in};
			end
			3'b101: begin
				done = 0;
				data = {data[6:0], in};
			end
			3'b110: begin
				done = 0;
				data = {data[6:0], in};
			end
			3'b111: begin
				done = 1;
				if (in)
					done = 0;
			end
		endcase
	end
	
endmodule
