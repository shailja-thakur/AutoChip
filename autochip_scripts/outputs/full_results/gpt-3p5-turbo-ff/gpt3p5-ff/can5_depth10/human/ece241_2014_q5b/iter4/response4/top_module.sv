module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

// States
reg [1:0] state;
parameter A = 2'b00;
parameter B = 2'b01;

// Outputs
always @(posedge clk, posedge areset) begin
	if(areset) begin
		z <= 1'b0;
	end else begin
		case(state)
			A: z <= 1'b0;
			B: z <= 1'b1;
		endcase
	end
end

// Next state logic
always @(posedge clk, posedge areset) begin
	if(areset) begin
		state <= A;
	end else begin
		case(state)
			A: begin
				if(x) begin
					state <= B;
				end else begin
					state <= A;
				end
			end
			B: begin
				if(x) begin
					state <= A;
				end else begin
					state <= B;
				end
			end
		endcase
	end
end

endmodule
