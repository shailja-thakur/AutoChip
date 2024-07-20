module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);


reg [1:0] state;
reg walk_left, walk_right, aaah, digging;


always@(posedge clk or posedge areset)
begin

	if(areset)
		begin
			state <= 2'b00;
			walk_left <= 1'b1;
			walk_right <= 1'b0;
			aaah <= 1'b0;
			digging <= 1'b0;
		end
	else
		begin
			case(state)
				2'b00:	//walking left state
					begin
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b0;
						
						if(bump_left)	//if bumped on left then switch direction
							state <= 2'b01;	//walking right state
						else
							state <= 2'b00;
						
						if(ground == 1'b0)	//if ground disappears, fall
							state <= 2'b10;	//falling state
						else if(dig)	//if told to dig, check conditions for digging
							begin
								if(ground)
									state <= 2'b11;	//digging state
							end
					end
					
				2'b01:	//walking right state
					begin
						walk_left <= 1'b0;
						walk_right <= 1'b1;
						aaah <= 1'b0;
						digging <= 1'b0;
						
						if(bump_right)	//if bumped on right then switch direction
							state <= 2'b00;	//walking left state
						else
							state <= 2'b01;
						
						if(ground == 1'b0)	//if ground disappears, fall
							state <= 2'b10;	//falling state
						else if(dig)	//if told to dig, check conditions for digging
							begin
								if(ground)
									state <= 2'b11;	//digging state
							end
					end
					
				2'b10:	//falling state
					begin
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b1;
						digging <= 1'b0;
						
						if(ground)	//if ground reappears, resume walking in previous direction
							begin
								if(state == 2'b00)
									state <= 2'b00;
								else if(state == 2'b01)
									state <= 2'b01;
							end
					end
					
				2'b11:	//digging state
					begin
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b1;
						
						if(ground == 1'b0)	//if ground disappears, fall
							state <= 2'b10;	//falling state
					end
					
				default:
					begin
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b0;
					end
			endcase
		end

end

endmodule
