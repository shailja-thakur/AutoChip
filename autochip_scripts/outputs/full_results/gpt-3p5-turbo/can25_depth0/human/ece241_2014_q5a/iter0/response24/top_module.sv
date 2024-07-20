module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [3:0] state;
reg z;
wire x_invert;
wire reset_invert;
wire stop_conversion;
wire start_conversion;

initial begin
	state = 4'b0000;
	z = 1'b0;
end

assign x_invert = ~x;
assign reset_invert = ~areset;
assign stop_conversion = (state == 4'b1111) ? 1'b1 : 1'b0;
assign start_conversion = (state == 4'b0000 && ~areset) ? 1'b1 : 1'b0;

always @(posedge clk or negedge areset) begin
	if (areset == 1'b0) begin
		// Reset state and output
		state <= 4'b0000;
		z <= 1'b0;
	end else begin
		// State transition logic
		case (state)
			4'b0000: begin
				if (start_conversion) begin
					state <= 4'b0001;
				end else begin
					state <= 4'b0000;
				end
			end
			4'b0001: begin
				state <= 4'b0010;
			end
			4'b0010: begin
				state <= 4'b0100;
			end
			4'b0100: begin
				state <= 4'b1000;
			end
			4'b1000: begin
				state <= 4'b0000;
			end
			default: begin
				state <= 4'b0000;
			end
		endcase
		
		// Output logic
		case (state)
			4'b1000: begin
				z <= 1'b1;
			end
			default: begin
				z <= 1'b0;
			end
		endcase
	end
end

endmodule
