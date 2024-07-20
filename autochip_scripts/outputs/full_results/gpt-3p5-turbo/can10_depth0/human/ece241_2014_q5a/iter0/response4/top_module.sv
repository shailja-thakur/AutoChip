module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	//state variable
	reg [3:0] state;
	//next state
	reg [3:0] next_state;

	always @(posedge clk or negedge areset) begin
		if (areset === 0) begin
			state <= 4'b0000;
		end else begin
			state <= next_state;
		end
	end

	always @(state or x) begin
		case (state)
			4'b0000: begin
				if (x === 1'b0) begin
					next_state = 4'b0011;
					z = 1'b0; // assumig z=0 for areset condition
				end else begin
					next_state = 4'b0001;
					z = 1'b1;
				end
			end
			4'b0001: begin
				if (x === 1'b0) begin
					next_state = 4'b0010;
					z = 1'b1;
				end else begin
					next_state = 4'b0001;
					z = 1'b0;
				end
			end
			4'b0010: begin
				if (x === 1'b0) begin
					next_state = 4'b0011;
					z = 1'b0;
				end else begin
					next_state = 4'b0001;
					z = 1'b1;
				end
			end
			4'b0011: begin
				if (x === 1'b0) begin
					next_state = 4'b0001;
					z = 1'b0;
				end else begin
					next_state = 4'b0011;
					z = 1'b0;
				end
			end
		endcase
	end
	
endmodule
