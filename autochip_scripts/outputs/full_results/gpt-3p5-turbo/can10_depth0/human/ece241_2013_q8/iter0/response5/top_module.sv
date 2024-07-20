module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;
reg [1:0] mem;

always @(posedge clk or negedge aresetn)
begin
	if (!aresetn)
	begin
		state <= 3'b000;
		mem <= 2'b00;
		z <= 1'b0;
	end
	else
	begin
		case (state)
			3'b000: begin
				       if (x == 1'b1)
					       state <= 3'b001;
				       else
					       state <= 3'b000;
			       end
			3'b001: begin
				       if (x == 1'b0)
					       state <= 3'b010;
				       else
					       state <= 3'b001;
			       end
			3'b010: begin
				       if (x == 1'b1)
				       begin
					       state <= 3'b011;
					       z <= 1'b1;
				       end
				       else
					       state <= 3'b010;
			       end
			3'b011: begin
				       if (x == 1'b0)
					       state <= 3'b010;
				       else
					       state <= 3'b011;
			       end
		endcase
	end
end

endmodule
