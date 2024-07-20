module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;
parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (in == 0)
                next_state = A;
            else
                next_state = B;
            out = 0;
        end
        B: begin
            if (in == 0)
                next_state = C;
            else
                next_state = B;
            out = 0;
        end
        C: begin
            if (in == 0)
                next_state = A;
            else
                next_state = D;
            out = 0;
        end
        D: begin
            if (in == 0)
                next_state = C;
            else
                next_state = B;
            out = 1;
        end
        default: begin
            next_state = A;
            out = 0;
        end
    endcase
end

endmodule
