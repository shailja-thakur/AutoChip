module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;
localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk) begin
    if (!resetn)
        state <= A;
    else
        state <= next;
end

always @(*) begin
    case (state)
        A:
            if (r[1])
                next = B;
            else if (r[2])
                next = C;
            else if (r[0])
                next = D;
            else
                next = A;
        B:
            if (r[1])
                next = B;
            else
                next = A;
        C:
            if (r[2])
                next = C;
            else
                next = A;
        D:
            if (r[0])
                next = D;
            else
                next = A;
    endcase
end

always @(*) begin
    g = 3'b000;
    case (state)
        B: g[1] = 1'b1;
        C: g[2] = 1'b1;
        D: g[0] = 1'b1;
    endcase
end

endmodule
