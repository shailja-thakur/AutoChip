module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset state to 1
        end else begin
            q[4] <= q[0];            // Shift 
            q[3] <= q[4];            // Shift
            q[2] <= q[3] ^ q[0];     // XOR tap at bit position 3
            q[1] <= q[2];
            q[0] <= q[1] ^ q[0];     // XOR tap at bit position 5 (output bit)
        end
    end

endmodule
