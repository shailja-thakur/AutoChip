module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [3:0] state;
	reg [3:0] next_state;
	
	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= 4'b0000;
		end else begin
			state <= next_state;
		end
	end
	
	always @(*) begin
		case (state)
			4'b0000: begin
				if (areset == 1) begin
					next_state = 4'b0001;
				end else begin
					next_state = 4'b0000;
				end
			end
			4'b0001: begin
				if (areset == 1) begin
					next_state = 4'b0010;
				end else begin
					next_state = 4'b0001;
				end
			end
			4'b0010: begin
				if (areset == 1) begin
					next_state = 4'b0011;
				end else begin
					next_state = 4'b0010;
				end
			end
			4'b0011: begin
				if (areset == 1) begin
					next_state = 4'b0100;
				end else begin
					next_state = 4'b0100;
				end
			end
			4'b0100: begin
				if (areset == 1) begin
					next_state = 4'b0101;
				end else begin
					next_state = 4'b0101;
				end
			end
			4'b0101: begin
				if (areset == 1) begin
					next_state = 4'b0110;
				end else begin
					next_state = 4'b0110;
				end
			end
			4'b0110: begin
				if (areset == 1) begin
					next_state = 4'b0111;
				end else begin
					next_state = 4'b0111;
				end
			end
			4'b0111: begin
				if (areset == 1) begin
					next_state = 4'b1000;
				end else begin
					next_state = 4'b1000;
				end
			end
			4'b1000: begin
				if (areset == 1) begin
					next_state = 4'b1001;
				end else begin
					next_state = 4'b1001;
				end
			end
			4'b1001: begin
				if (areset == 1) begin
					next_state = 4'b1010;
				end else begin
					next_state = 4'b1010;
				end
			end
			4'b1010: begin
				if (areset == 1) begin
					next_state = 4'b1011;
				end else begin
					next_state = 4'b1011;
				end
			end
			4'b1011: begin
				if (areset == 1) begin
					next_state = 4'b1100;
				end else begin
					next_state = 4'b1100;
				end
			end
			4'b1100: begin
				if (areset == 1) begin
					next_state = 4'b1101;
				end else begin
					next_state = 4'b1101;
				end
			end
			4'b1101: begin
				if (areset == 1) begin
					next_state = 4'b1110;
				end else begin
					next_state = 4'b1110;
				end
			end
			4'b1110: begin
				if (areset == 1) begin
					next_state = 4'b1111;
				end else begin
					next_state = 4'b1111;
				end
			end
			4'b1111: begin
				if (areset == 1) begin
					next_state = 4'b0000;
				end else begin
					next_state = 4'b0000;
				end
			end
		endcase
	end
	
	// Output logic
	assign z = (state == 4'b0000) ? ~x + 1 : x;
	
endmodule
