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

	// state declaration
	reg [3:0] state;

	// next state and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 4'b0101;
        end else begin
        	case(state)
        		4'b0101: begin
        			if (bump_left && bump_right) begin
        				state <= 4'b1000;
        			end else if (bump_left) begin
        				state <= 4'b0010;
        			end else if (bump_right) begin
        				state <= 4'b0001;
        			end else if (dig) begin
        				state <= 4'b0111;
        			end else if (ground == 0) begin
        				state <= 4'b1011;
        			end
        		end
        		4'b0010: begin
        			state <= 4'b1000;
        		end
        		4'b0001: begin
        			state <= 4'b1000;
        		end
        		4'b1000: begin
        			state <= 4'b0101;
        		end
        		4'b0111: begin
        			if (ground == 0) begin
        				state <= 4'b1011;
        			end else begin
        				state <= 4'b0111;
        			end
        		end
        		4'b1011: begin
        			state <= 4'b0110;
        		end
        		4'b0110: begin
        			if (ground) begin
        				state <= 4'b0101;
        			end else begin
        				state <= 4'b0110;
        			end
        		end
        	endcase
        end
	end

	// output assignment
	assign walk_left = (state == 4'b0101) ? 1'b1 : 1'b0;
	assign walk_right = (state == 4'b0101) ? 1'b0 : 1'b1;
	assign aaah = (state == 4'b1011) ? 1'b1 : 1'b0;
	assign digging = (state == 4'b0110) ? 1'b1 : 1'b0;
endmodule
