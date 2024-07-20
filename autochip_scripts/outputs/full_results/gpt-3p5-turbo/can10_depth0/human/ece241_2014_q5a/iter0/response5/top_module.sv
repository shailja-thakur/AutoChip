module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
reg [2:0] state;

always @(posedge clk or posedge areset)
begin
	if (areset)
		begin
			state <= 3'b000;
			z <= 1'b0;
		end
	else
		begin
			case (state)
				3'b000: 
					begin
						if (x)
							begin
								state <= 3'b001;
								z <= !x;
							end
				        else
							begin
								state <= 3'b000;
								z <= 1'b0;
							end
					end
				3'b001: 
					begin
						if (x)
							begin
								state <= 3'b001;
								z <= !x;
							end
						else
							begin
								state <= 3'b010;
								z <= !x;
							end
					end
				3'b010: 
					begin
						if (x)
							begin
								state <= 3'b010;
								z <= !x;
							end
						else
							begin
								state <= 3'b011;
								z <= !x;
							end
					end
				3'b011: 
					begin
						if (x)
							begin
								state <= 3'b011;
								z <= !x;
							end
						else
							begin
								state <= 3'b000;
								z <= !x;
							end
					end
			endcase
		end
end

endmodule
