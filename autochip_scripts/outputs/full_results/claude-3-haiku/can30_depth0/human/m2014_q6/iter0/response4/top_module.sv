module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [3:0] state, next_state;
parameter A = 4'd0, B = 4'd1, C = 4'd2, D = 4'd3, E = 4'd4, F = 4'd5;

always @(posedge clk) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A:
            if (w)
                next_state = A;
            else
                next_state = B;
        B:
            if (w)
                next_state = D;
            else
                next_state = C;
        C:
            if (w)
                next_state = D;
            else
                next_state = E;
        D:
            if (w)
                next_state = A;
            else
                next_state = F;
        E:
            if (w)
                next_state = D;
            else
                next_state = E;
        F:
            if (w)
                next_state = D;
            else
                next_state = C;
        default:
            next_state = A;
    endcase
end

assign z = (state == E) || (state == F);

endmodule
