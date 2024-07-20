module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [2:0] state;
	reg next_state;
	always @(posedge clk or negedge resetn) begin
		if(~resetn) begin
			state <= 3'b000;
		end
		else begin
			state <= next_state;
		end
	end

	always @(state or x or y) begin
		case(state)
			3'b000: begin
				f <= 0;
				g <= 0;
				if(x) begin
					next_state <= 3'b001;
				end
				else if(~resetn) begin
					next_state <= 3'b000;
				end
			end
			3'b001: begin
				f <= 1;
				g <= 0;
				if(x) begin
					next_state <= 3'b010;
				end
				else if(~resetn) begin
					next_state <= 3'b001;
				end
			end
			3'b010: begin
				f <= 0;
				g <= 0;
				if(x) begin
					next_state <= 3'b011;
				end
				else if(~resetn) begin
					next_state <= 3'b000;
				end
			end
			3'b011: begin
				f <= 0;
				if(x) begin
					next_state <= 3'b100;
				end
				else if(~resetn) begin
					next_state <= 3'b000;
				end
			end
			3'b100: begin
				if(y && x) begin
					f <= 0;
					g <= 1;
					next_state <= 3'b101;
				end
				else if(~resetn) begin
					f <= 0;
					g <= 0;
					next_state <= 3'b000;
				end
				else begin
					f <= 0;
					g <= 0;
					next_state <= 3'b100;
				end
			end
			3'b101: begin
				if(y && x) begin
					f <= 0;
					g <= 1;
					next_state <= 3'b101;
				end
				else if(y && ~x) begin
					f <= 1;
					g <= 1;
					next_state <= 3'b101;
				end
				else if(~resetn) begin
					f <= 0;
					g <= 0;
					next_state <= 3'b000;
				end
				else begin
					f <= 0;
					g <= 0;
					next_state <= 3'b010;
				end
			end
			default: begin
				f <= 0;
				g <= 0;
				next_state <= 3'b000;
			end
		endcase
	end

endmodule
