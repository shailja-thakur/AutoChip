module top_module(
    input wire clk,
    input wire reset,
    output wire [31:0] q);

    reg [31:0] next_q;
    wire feedback;

    assign feedback = q[31] ^ q[21] ^ q[1] ^ q[0];

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            q <= 32'h1;
        else
        begin
            next_q[0] <= feedback;
            next_q[1] <= q[0];
            next_q[2] <= q[1];
            next_q[31:3] <= q[30:2];
            q <= next_q;
        end
    end
endmodule
