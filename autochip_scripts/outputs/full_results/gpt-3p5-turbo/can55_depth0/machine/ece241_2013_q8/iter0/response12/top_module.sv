module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// state signals
	reg [3:0] state, state_next;

	// state assignments
	always @(posedge clk or negedge aresetn) begin
		if(!aresetn) begin
			state <= 4'b0000;
		end else begin
			state <= state_next;
		end
	end
	
	// state next logic
	always @(*) begin
		case(state)
			4'b0000: begin
				if(x == 1'b0)
					state_next = 4'b0000;
				else if(x == 1'b1)
					state_next = 4'b0001;
			end
			4'b0001: begin
				if(x == 1'b0)
					state_next = 4'b0010;
				else if(x == 1'b1)
					state_next = 4'b0001;
			end
			4'b0010: begin
				if(x == 1'b0)
					state_next = 4'b0000;
				else if(x == 1'b1)
					state_next = 4'b0001;
			end
			default: begin
				state_next = 4'bxxxx;
			end
		endcase
	end
	
	// output logic
	always @(state) begin
		case(state)
			4'b0000, 4'b0001: begin
				z = 1'b0;
			end
			4'b0010: begin
				z = x;
			end
			default: begin
				z = 1'b0;
			end
		endcase
	end
endmodule
