module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

    wire feedback;

    assign feedback = q[0] ^ q[21] ^ q[1] ^ q[0]; // correct the feedback to include double XOR with q[0]

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q[30:0], feedback};
        end
    end

endmodule
