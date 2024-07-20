module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    wire feedback;

    // taps at bit positions 5 and 3
    assign feedback = q[4] ^ q[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Active-high synchronous reset
        end else begin
            q <= {q[3:0], feedback}; // Shift and feedback
        end
    end

endmodule
