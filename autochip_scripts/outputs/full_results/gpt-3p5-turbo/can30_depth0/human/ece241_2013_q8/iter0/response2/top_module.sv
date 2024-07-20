module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [1:0] state;
wire [2:0] seq;
assign seq = {x, seq[2:1]};

always @(posedge clk or negedge aresetn) begin
	if (!aresetn) begin
		state <= 2'b00;
		z <= 1'b0;
	end else begin
		case(state)
			2'b00: begin
				if(seq == 3'b101) begin
					state <= 2'b01;
					z <= 1'b1;
				end else begin
					state <= 2'b00;
					z <= 1'b0;
				end
			end
			
			2'b01: begin
				if(seq == 3'b101) begin
					state <= 2'b11;
					z <= 1'b1;
				end else if (seq == 3'b10) begin
					state <= 2'b01;
					z <= 1'b1;
				end else begin
					state <= 2'b00;
					z <= 1'b0;
				end
			end
			
			2'b11: begin
				if(seq == 3'b10) begin
					state <= 2'b01;
					z <= 1'b1;
				end else if (seq == 3'b101) begin
					state <= 2'b11;
					z <= 1'b1;
				end else begin
					state <= 2'b00;
					z <= 1'b0;
				end
			end
			
			default: state <= 2'b00;
		endcase
	end
end

endmodule
