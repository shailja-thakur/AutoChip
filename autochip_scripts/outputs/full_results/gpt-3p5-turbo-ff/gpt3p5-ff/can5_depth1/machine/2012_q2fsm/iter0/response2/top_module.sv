module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

reg [2:0] state;
initial begin
	state <= 3'b000;   //Initializing the state register to state A
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;   //Resetting the state register to state A
	end
	else begin
		case (state)
			3'b000: begin   //State A
				if (w) begin
					state <= 3'b001;
				end
				else begin
					state <= 3'b000;
				end
			end
			3'b001: begin   //State B
				if (w) begin
					state <= 3'b010;
				end
				else begin
					state <= 3'b011;
				end
			end
			3'b010: begin   //State C
				if (w) begin
					state <= 3'b110;
				end
				else begin
					state <= 3'b110;
				end
			end
			3'b011: begin   //State D
				if (w) begin
					state <= 3'b111;
				end
				else begin
					state <= 3'b000;
				end
			end
			3'b110: begin   //State E
				if (w) begin
					state <= 3'b110;
				end
				else begin
					state <= 3'b011;
				end
			end
			3'b111: begin   //State F
				if (w) begin
					state <= 3'b010;
				end
				else begin
					state <= 3'b110;
				end
			end
			default: state <= 3'b000;
		endcase
	end
end

assign z = (state == 3'b110 || state == 3'b111);   //Setting output z to 1 if state is E or F

endmodule
