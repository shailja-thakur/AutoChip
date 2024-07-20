module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	reg [3:1] state, next_state;
	
	always @(posedge clk or negedge resetn) begin
		if(!resetn)
			state <= 3'b001;
		else
			state <= next_state;
	end
	
	always @(state or r) begin
		next_state = state; // default next state is current state
		case(state)
			3'b001: begin // A
				if(r[1] == 1'b1)
					next_state = 3'b010;
				else if(r[1] == 1'b0 && r[2] == 1'b1)
					next_state = 3'b011;
				else if(r[1] == 1'b0 && r[2] == 1'b0 && r[3] == 1'b0)
					next_state = 3'b100;
			end
			
			3'b010: begin // B
				if(r[1] == 1'b1 && g[1] == 1'b1)
					next_state = 3'b010;
				else if(r[1] == 1'b0 || g[1] == 1'b0)
					next_state = 3'b001;
			end
			
			3'b011: begin // C
				if(r[2]  == 1'b1 && g[2] == 1'b1)
					next_state = 3'b011;
				else if(r[2] == 1'b0 || g[2] == 1'b0)
					next_state = 3'b001;
			end
			
			3'b100: begin // D
				next_state = 3'b001;
			end
		endcase
	end
	
	always @(posedge clk or negedge resetn) begin
		if(!resetn)
			g <= 3'b000;
		else begin
			case(state)
				3'b001: begin // A
					g <= 3'b000;
				end
				
				3'b010: begin // B
					g <= 3'b100;
				end
				
				3'b011: begin // C
					g <= 3'b010;
				end
				
				3'b100: begin // D
					g <= 3'b001;
				end
			endcase
		end
	end
	
endmodule
