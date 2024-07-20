module top_module(
	input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);
	// Create 16 D flip-flops
	reg [15:0] q_temp;

	// Process each byte enable separately
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			q_temp <= 16'b0; // Reset all flip-flops to 0
		end else begin
			// Update each byte based on byte enable
			if (byteena[0]) begin
				q_temp[7:0] <= d[7:0];
			end
			if (byteena[1]) begin
				q_temp[15:8] <= d[15:8];
			end
		end
	end

	// Assign q to q_temp
	assign q = q_temp;
endmodule
