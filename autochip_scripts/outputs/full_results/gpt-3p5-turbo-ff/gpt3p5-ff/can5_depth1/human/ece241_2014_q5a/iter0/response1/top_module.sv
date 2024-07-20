module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [7:0] count;
	reg [7:0] sum;

	parameter IDLE = 2'b00;
	parameter ADD = 2'b01;
	parameter SUB = 2'b10;
	reg [1:0] state, next_state;
	wire start_convert;
	assign start_convert = (state == IDLE & !areset) ? 1'b1 : 1'b0;

	always @(posedge clk or negedge areset) begin
		if(areset == 0) begin
			count <= 8'b0;
			sum <= 8'b0;
			state <= IDLE;
		end else begin
			count <= count + 1;
			if(start_convert) begin
				sum <= {1'b0, x};
			end else begin
				sum <= sum + x;
			end
			state <= next_state;
		end
	end

	always @(posedge clk) begin
		if(areset == 0) begin
			next_state <= IDLE;
		end else begin
			case(state)
				IDLE: begin
					if(start_convert) begin
						next_state <= ADD;
					end else begin
						next_state <= IDLE;
					end
				end
				ADD: begin
					if(count == 8) begin
						next_state <= SUB;
					end else begin
						next_state <= ADD;
					end
				end
				SUB: begin
					if(count == 8) begin
						next_state <= IDLE;
					end else begin
						next_state <= SUB;
					end
				end
			endcase
		end
	end

	assign z = sum;
	
endmodule
