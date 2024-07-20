module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    wire feedback;

    // Define the feedback function based on tap positions 32, 22, 2, and 1
    assign feedback = q[31] ^ q[21] ^ q[1] ^ q[0];

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q[30:0], feedback};
        end
    end
endmodule
