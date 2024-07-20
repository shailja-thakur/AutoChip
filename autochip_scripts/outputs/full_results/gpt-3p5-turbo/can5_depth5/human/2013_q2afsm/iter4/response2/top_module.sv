module top_module (
	input clk,
	input resetn,
	input [3:0] r,
	output reg [3:0] g
);

	reg [3:0] state, next_state;
	
	always @(posedge clk or negedge resetn) begin
		if(!resetn)
			state <= 4'b0001;
		else
			state <= next_state;
	end
	
	always @(state or r) begin
		case(state)
			4'b0001: begin // A
				if(r[1] == 1'b0 && r[2] == 1'b0 && r[3] == 1'b0)
					next_state = 4'b0001;
				else if(r[1] == 1'b1)
					next_state = 4'b0010;
				else if(r[1] == 1'b0 && r[2] == 1'b1)
					next_state = 4'b0011;
				else if(r[1] == 1'b0 && r[2] == 1'b0 && r[3] == 1'b1)
					next_state = 4'b0100;
			end
			
			4'b0010: begin // B
				if(r[1] == 1'b1)
					next_state = 4'b0010;
				else if(r[1] == 1'b0)
					next_state = 4'b0001;
			end
			
			4'b0011: begin // C
				if(r[2] == 1'b1)
					next_state = 4'b0011;
				else if(r[2] == 1'b0)
					next_state = 4'b0001;
			end
			
			4'b0100: begin // D
				if(r[1] == 1'b0 && r[2] == 1'b0 && r[3] == 1'b0)
					next_state = 4'b0001;
			end
		endcase
	end
	
	always @(posedge clk or negedge resetn) begin
		if(!resetn)
			g <= 4'b0000;
		else begin
			case(state)
				4'b0001: begin // A
					g <= 4'b0000;
				end
				
				4'b0010: begin // B
					g <= 4'b1000;
				end
				
				4'b0011: begin // C
					g <= 4'b0100;
				end
				
				4'b0100: begin // D
					g <= 4'b0010;
				end
			endcase
		end
	end
	
endmodule
