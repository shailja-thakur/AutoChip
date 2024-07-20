module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

localparam [1:0] IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b10;
reg [1:0] state, next_state;
reg [7:0] acc;
reg [3:0] count;

always @(posedge clk, negedge areset) begin
	if (!areset) begin
		state <= IDLE;
		acc <= 0;
		count <= 0;
		z <= 0;
	end
	else begin
		state <= next_state;
		case (state)
			IDLE: begin
				z <= 0;
				if (x) begin
					acc <= 1;
					count <= 1;
					next_state <= CONVERT;
				end
				else begin
					next_state <= IDLE;
				end
			end
			CONVERT: begin
				acc <= {acc[6:0], x};
				count <= count + 1;
				if (x) begin
					z <= 0;
				end
				else begin
					z <= 1;
				end
				if (count == 8) begin
					acc <= ~acc + 1;
					next_state <= DONE;
				end
				else begin
					next_state <= CONVERT;
				end
			end
			DONE: begin
				z <= acc[0];
				if (areset) begin
					next_state <= IDLE;
				end
				else begin
					next_state <= DONE;
				end
			end
		endcase
	end
end

endmodule
