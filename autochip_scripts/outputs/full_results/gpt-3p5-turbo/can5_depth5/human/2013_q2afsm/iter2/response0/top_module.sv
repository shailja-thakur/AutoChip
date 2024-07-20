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
		case(state)
			3'b001: begin // A
				if(r[1] == 0 && r[2] == 0 && r[3] == 0)
					next_state = 3'b001;
				else if(r[1] == 1)
					next_state = 3'b010;
				else if(r[1] == 0 && r[2] == 1)
					next_state = 3'b011;
				else if(r[1] == 0 && r[2] == 0 && r[3] == 1)
					next_state = 3'b100;
			end
			
			3'b010: begin // B
				if(r[1] == 1)
					next_state = 3'b010;
				else if(r[1] == 0 && g[1] == 1)
					next_state = 3'b001;
			end
			
			3'b011: begin // C
				if(r[2] == 1)
					next_state = 3'b011;
				else if(r[2] == 0 && g[2] == 1)
					next_state = 3'b001;
			end
			
			3'b100: begin // D
				next_state = 3'b001;
			end
		endcase
	end
	
	always @* begin
		case(state)
			3'b001: g = 3'b000;
			3'b010: g = 3'b100;
			3'b011: g = 3'b010;
			3'b100: g = 3'b001;
		endcase
	end
	
endmodule
