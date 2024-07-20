module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

    // Taps at bit positions 5 and 3 correspond to q[4] and q[2]
    wire feedback;

    // Feedback is the XOR of the tapped bits
    assign feedback = q[4] ^ q[2];

    always @(posedge clk) begin
        if (reset) begin
            // Reset to 1 on active-high reset
            q <= 5'b00001;
        end
        else begin
            // Shift left and introduce feedback
            q <= {q[3:0], feedback};
        end
    end
endmodule
