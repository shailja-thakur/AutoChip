module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	// Declare intermediate wires
	wire [512:0] q_extended;
	wire [511:0] left_neighbour;
	wire [511:0] right_neighbour;
	
	// Assign values to intermediate wires
	assign q_extended[0] = 0;
	assign q_extended[1:512] = q;
	assign left_neighbour = q_extended[511:0];
	assign right_neighbour = q_extended[2:512];
	
	// Compute next state based on cell neighbours
	always @ (posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			for (int i = 0; i < 512; i = i + 1) begin
				case ({left_neighbour[i], q[i], right_neighbour[i]})
					3'b111: q[i] <= 1'b0;
					3'b110: q[i] <= 1'b1;
					3'b101: q[i] <= 1'b0;
					3'b100: q[i] <= 1'b1;
					3'b011: q[i] <= 1'b1;
					3'b010: q[i] <= 1'b0;
					3'b001: q[i] <= 1'b1;
					3'b000: q[i] <= 1'b0;
				endcase
			end
		end
	end
endmodule
