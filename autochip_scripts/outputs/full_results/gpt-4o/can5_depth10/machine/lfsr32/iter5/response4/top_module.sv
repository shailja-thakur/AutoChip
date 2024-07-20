module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

    wire feedback;

    // Bits 21 and 1 are XORed with the value of bit 0 (q[0])
    assign feedback = q[0] ^ q[21] ^ q[1];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1; // Initial value on reset
        end else begin
            q <= {q[30:0], feedback}; // Shift left and insert feedback at bit 0
        end
    end

endmodule
