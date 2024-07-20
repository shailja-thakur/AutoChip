module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	reg [1:0] state;
	reg [2:0] shift_register;
	
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn) begin
			state <= S0;
			shift_register <= 3'b000;
			z <= 0;
		end else begin
			case (state)
				S0: begin
					if (x == 1'b1)
						shift_register <= {shift_register[1:0], 1'b1};
					else
						shift_register <= {shift_register[1:0], 1'b0};
					
					if (shift_register == 3'b101) begin
						state <= S1;
						z <= 1;
					end else begin
						state <= S0;
						z <= 0;
					end
				end
				S1: begin
					if (x == 1'b1)
						shift_register <= {shift_register[1:0], 1'b1};
					else
						shift_register <= {shift_register[1:0], 1'b0};
					
					if (shift_register == 3'b101) begin
						state <= S2;
						z <= 1;
					end else begin
						state <= S0;
						z <= 0;
					end
				end
				S2: begin
					if (x == 1'b1)
						shift_register <= {shift_register[1:0], 1'b1};
					else
						shift_register <= {shift_register[1:0], 1'b0};
					
					if (shift_register == 3'b101) begin
						state <= S2;
						z <= 1;
					end else begin
						state <= S0;
						z <= 0;
					end
				end
			endcase
		end
	end
endmodule
