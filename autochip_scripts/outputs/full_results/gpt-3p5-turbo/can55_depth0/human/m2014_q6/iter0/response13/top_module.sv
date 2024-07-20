module top_module (
	input clk,
	input reset,
	input w,
	output z
);
 
reg [2:0] state;
 
initial begin
	state = 3'b000;
end
 
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000;
	else begin
		case (state)
			3'b000: begin // A
				if (w)
					state <= 3'b000;
				else
					state <= 3'b001;
			end
			
			3'b001: begin // B
				if (w)
					state <= 3'b010;
				else
					state <= 3'b011;
			end
			
			3'b010: begin // C
				if (w)
					state <= 3'b101;
				else
					state <= 3'b011;
			end
			
			3'b011: begin // D
				if (w)
					state <= 3'b100;
				else
					state <= 3'b001;
			end
			
			3'b100: begin // E
				if (w)
					state <= 3'b100;
				else
					state <= 3'b001;
			end
			
			3'b101: begin // F
				if (w)
					state <= 3'b010;
				else
					state <= 3'b011;
			end
			
			default: state <= 3'b000;
		endcase
	end
end
 
assign z = state[2];
 
endmodule
