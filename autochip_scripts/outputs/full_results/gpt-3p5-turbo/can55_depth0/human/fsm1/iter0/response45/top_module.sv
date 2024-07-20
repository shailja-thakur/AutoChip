module top_module (
       input clk,
       input in,
       input areset,
       output reg out
);

reg [1:0] state = 2'b00;
reg out_reg;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else begin
		case(state)
			2'b00: if(in) state <= 2'b01;
			       else    state <= 2'b00;
			2'b01: if(in) state <= 2'b01;
			       else    state <= 2'b00;
		endcase
	end
end

always @(state) begin
	case(state)
		2'b00: out_reg = 1'b1;
		2'b01: out_reg = 1'b0;
	endcase
end

assign out = out_reg;

endmodule
