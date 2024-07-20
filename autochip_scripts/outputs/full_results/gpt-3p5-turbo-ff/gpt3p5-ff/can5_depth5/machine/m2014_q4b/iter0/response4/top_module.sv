module top_module (
	input clk,
	input logic d,
	input logic ar,
	output logic q
);

	always_ff @(posedge clk or posedge ar) begin
		if (ar) begin
			q <= 0;  
		end else begin
			q <= d;
		end
	end

endmodule
