module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	localparam WIDTH = 16;
	reg [WIDTH-1:0] q_rows[0:WIDTH-1];
	wire [WIDTH-1:0] q_neighbors[WIDTH-1:0][WIDTH-1:0];
	reg [WIDTH-1:0] q_next[0:WIDTH-1];

	generate
		for (genvar i = 0; i < WIDTH; i++) begin : GEN_Q_ROWS
			assign q_rows[i] = q[i*WIDTH +: WIDTH];
		end
	endgenerate

	generate
		for (genvar i = 0; i < WIDTH; i++) begin : GEN_Q_NEIGHBORS
			for (genvar j = 0; j < WIDTH; j++) begin : GEN_Q_NEIGHBOR_ROWS
				assign q_neighbors[i][j] = {q_rows[(i+WIDTH-1)%WIDTH][j], q_rows[(i+WIDTH-1)%WIDTH][(j+WIDTH-1)%WIDTH], q_rows[(i+WIDTH-1)%WIDTH][(j+1)%WIDTH], q_rows[i][(j+WIDTH-1)%WIDTH], q_rows[i][(j+1)%WIDTH], q_rows[(i+1)%WIDTH][j], q_rows[(i+1)%WIDTH][(j+WIDTH-1)%WIDTH], q_rows[(i+1)%WIDTH][(j+1)%WIDTH]};
			end
		end
	endgenerate

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			for (int i = 0; i < WIDTH; i=i+1) begin : UPDATE_Q
				for (int j = 0; j < WIDTH; j=j+1) begin : UPDATE_Q_ROW
					case (q_neighbors[i][j])
						2'b00: q_next[i][j] = 1'b0;
						2'b01: q_next[i][j] = q_rows[i][j];
						2'b10: q_next[i][j] = q_rows[i][j];
						2'b11: q_next[i][j] = 1'b1;
						default: q_next[i][j] = 1'b0;
					endcase
				end
			end

			for (int i = 0; i < WIDTH; i=i+1) begin : UPDATE_Q
				q_rows[i] <= q_next[i];
			end

			for (int i = 0; i < WIDTH; i=i+1) begin : UPDATE_Q
				q[i*WIDTH +: WIDTH] <= q_rows[i];
			end
		end
	end
endmodule
