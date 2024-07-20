module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);
	
	reg [2:0] state;
	wire output;

	assign start_shifting = (state == 3'b111); 

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 3'b000;
		else
		begin
			case (state)
				3'b000: state <= (data) ? 3'b001 : 3'b000;
				3'b001: state <= (data) ? 3'b011 : 3'b000;
				3'b011: state <= (data) ? 3'b011 : 3'b110;
				3'b110: state <= (data) ? 3'b111 : 3'b000;
				3'b111: state <= 3'b111;
			endcase
		end
	end
endmodule
