module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

    // Galois LFSR taps: 32, 22, 2, 1
    wire feedback;

    assign feedback = q[31] ^ q[21] ^ q[1] ^ q[0];

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // reset state
        end
        else begin
            q <= {q[30:0], feedback}; // shift and feedback
        end
    end
endmodule
