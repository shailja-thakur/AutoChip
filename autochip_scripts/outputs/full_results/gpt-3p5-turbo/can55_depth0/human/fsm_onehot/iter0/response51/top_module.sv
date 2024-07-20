module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	// Output declarations
	wire [9:0] temp_next_state;
	reg [1:0] temp_out;
	
	// Define the logic equations
	assign temp_next_state = (state == 10'd0)	? 10'b0000000001 :
							(state == 10'd1)	? 10'b0000000010 :
							(state == 10'd2)	? 10'b0000000100 :
							(state == 10'd3)	? 10'b0000001000 :
							(state == 10'd4)	? 10'b0000010000 :
							(state == 10'd5)	? 10'b0000100000 :
							(state == 10'd6)	? 10'b0001000000 :
							(state == 10'd7)	? 10'b0010000000 :
							(state == 10'd8)	? 10'b0100000000 :
							(state == 10'd9)	? 10'b1000000000 :
							10'bxxxxxxxxxx;
	
	assign out1 = (state == 10'd9 || state == 10'd7) ? 1'b1 : 1'b0;
	assign out2 = (state == 10'd7) ? 1'b1 : 1'b0;
	
	// Apply D flip-flops for registered output
	always @(posedge clk or posedge reset) begin
		if (reset)
			temp_out <= 2'b00;
		else
			temp_out <= {out1, out2};
	end
	
	// Output assignments
	assign next_state = temp_next_state;
	assign {out1, out2} = temp_out;
endmodule
