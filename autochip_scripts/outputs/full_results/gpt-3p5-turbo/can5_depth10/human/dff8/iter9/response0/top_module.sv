module top_module (
    input wire clk,
    input wire [7:0] d,
    output reg [7:0] q
);

    reg [7:0] q_next;

    always @(posedge clk)
        q <= q_next;

    always @*
        q_next = d;

endmodule
