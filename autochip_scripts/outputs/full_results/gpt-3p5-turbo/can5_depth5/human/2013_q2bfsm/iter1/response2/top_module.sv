module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
	reg [1:0] state;
	reg [2:0] x_history;
	reg [1:0] count;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= 2'b00; // state A
		else begin
			case (state)
				2'b00: begin // state A
					state <= 2'b01; // transition to state B
					f <= 1'b0; // reset f
					x_history <= 0; // reset x_history
					count <= 0; // reset count
				end
				2'b01: begin // state B
					if (x == 1'b1)
						state <= 2'b10; // transition to state C
				end
				2'b10: begin // state C
					if (x == 1'b0)
						state <= 2'b01; // transition back to state B
					else if (x_history == 3'b101)
						state <= 2'b11; // transition to state D
				end
				2'b11: begin // state D
					if (y != 1'b1)
						state <= 2'b01; // transition back to state B
				end
			endcase
		end
	end
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			g <= 1'b0; // reset g
		else begin
			case (state)
				2'b10, 2'b11: g <= 1'b1; // g = 1 in state C and D
				default: g <= 1'b0; // g = 0 in other states
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (~resetn)
			x_history <= 0; // reset x_history
		else begin
			x_history <= {x_history[1:0], x}; // update x_history
			if (x_history == 3'b101)
				count <= count + 1; // increment count
			else
				count <= 0; // reset count
		end
	end
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			f <= 1'b0; // reset f
		else begin
			case (state)
				2'b01: f <= 1'b1; // set f to 1 in state B
				2'b10, 2'b11: begin // set f to 1 in state C and D if count is less than or equal to 2
					if (count <= 2)
						f <= 1'b1;
				end
				default: f <= 1'b0; // reset f in other states
			endcase
		end
	end
	
endmodule
