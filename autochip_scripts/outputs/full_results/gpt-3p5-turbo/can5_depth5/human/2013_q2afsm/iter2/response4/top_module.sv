module fsm_module (
	input clk,
	input resetn,
	input [2:0] r,
	output reg [2:0] g
);

	reg [2:0] state, next_state;

	always @(posedge clk or negedge resetn) begin
		if(!resetn)
			state <= 3'b001;
		else
			state <= next_state;
	end

	always @(state or r) begin
		case(state)
			3'b001: begin // A
				if(r[0] == 1'b0 && r[1] == 1'b0 && r[2] == 1'b0)
					next_state = 3'b001;
				else if(r[0] == 1'b1)
					next_state = 3'b010;
				else if(r[0] == 1'b0 && r[1] == 1'b1)
					next_state = 3'b011;
				else if(r[0] == 1'b0 && r[1] == 1'b0 && r[2] == 1'b1)
					next_state = 3'b100;
			end
			
			3'b010: begin // B
				if(r[0] == 1'b1)
					next_state = 3'b010;
				else if(r[0] == 1'b0 && g[0] == 1'b1)
					next_state = 3'b001;
			end
			
			3'b011: begin // C
				if(r[1] == 1'b1)
					next_state = 3'b011;
				else if(r[1] == 1'b0 && g[1] == 1'b1)
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
