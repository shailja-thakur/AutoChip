module top_module (
    input clk,
    input reset,
    output reg [31:0] q
);

    wire feedback;

    // Correct the feedback logic: Bit 0 should XOR with bits 21, 1 and itself, which simplifies to XOR bits 21 and 1 directly
    assign feedback = q[21] ^ q[1];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            // Shift register with feedback on MSB
            q <= {feedback, q[31:1]};
        end
    end

endmodule
