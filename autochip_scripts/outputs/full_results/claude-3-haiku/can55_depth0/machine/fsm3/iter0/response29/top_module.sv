module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A:
            if (in)
                next_state = B;
            else
                next_state = A;
        B:
            if (in)
                next_state = B;
            else
                next_state = C;
        C:
            if (in)
                next_state = D;
            else
                next_state = A;
        D:
            if (in)
                next_state = B;
            else
                next_state = C;
        default:
            next_state = A;
    endcase

    out = (state == D);
end

endmodule
