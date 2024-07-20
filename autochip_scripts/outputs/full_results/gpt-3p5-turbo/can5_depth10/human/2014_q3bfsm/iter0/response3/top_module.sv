module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] y, next_y;
reg [1:0] state;
always @(posedge clk) begin
	if (reset) begin
		y <= 3'b000 ;
		state <= 2'b00 ; 
	end 
	else begin
		y <= next_y;
		state <= next_state;
	end
end

always @(y or x) begin
	case (y)
		3'b000: begin
			if (x) begin
				next_y = 3'b001;
				next_state = 2'b00;
				z = 1'b0;
			end
			else begin
				next_y = 3'b000;
				next_state = 2'b01;
				z = 1'b0;
			end
		end
		3'b001: begin
			if (x) begin
				next_y = 3'b100;
				next_state = 2'b00;
				z = 1'b0;
			end
			else begin
				next_y = 3'b001;
				next_state = 2'b10;
				z = 1'b0;
			end
		end
		3'b010: begin
			if (x) begin
				next_y = 3'b001;
				next_state = 2'b00;
				z = 1'b0;
			end
			else begin
				next_y = 3'b010;
				next_state = 2'b11;
				z = 1'b0;
			end
		end
		3'b011: begin
			if (x) begin
				next_y = 3'b010;
				next_state = 2'b00;
				z = 1'b1;
			end
			else begin
				next_y = 3'b001;
				next_state = 2'b11;
				z = 1'b0;
			end
		end
		3'b100: begin
			if (x) begin
				next_y = 3'b100;
				next_state = 2'b01;
				z = 1'b1;
			end
			else begin
				next_y = 3'b011;
				next_state = 2'b00;
				z = 1'b1;
			end
		end
	endcase
end
endmodule
