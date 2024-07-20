module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

    wire feedback;

    // Correct feedback calculation: XOR bits 0, 21, and 1
    assign feedback = q[0] ^ q[21] ^ q[1];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {feedback, q[31:1]};  // Correct shift operation with feedback as the new MSB
        end
    end

endmodule
