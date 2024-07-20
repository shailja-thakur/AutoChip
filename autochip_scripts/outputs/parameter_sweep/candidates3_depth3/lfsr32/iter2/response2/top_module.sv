module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;  // Change 1'b1 to 32'h1 to match the width of 'q'
		end else begin
			q <= {q[30:0], q[22] ^ q[1]};  // Remove q[0] and q[31] from the XOR equation
		end
	end

endmodule
