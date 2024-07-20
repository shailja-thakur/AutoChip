module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg [1:0] state;
	// initialize state to A
	always @(posedge clk or posedge reset) begin
		if(reset)
			state <= 2'b00; //A
		else if(state == 2'b00) begin //A
			if(j)
				state <= 2'b01; //B
		end else if (state == 2'b01) begin //B
			if(k)
				state <= 2'b00; //A
		end
	end
	
	// assign output based on current state
	always @(state) begin
		if(state == 2'b01) //B
			out <= 1'b1;
		else //A
			out <= 1'b0;
	end
endmodule
