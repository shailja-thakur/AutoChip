module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    case (state)
        A: begin
            if (in)
                next_state = B;
        end
        B: begin
            if (in)
                next_state = B;
            else
                next_state = C;
        end
        C: begin
            if (in)
                next_state = D;
            else
                next_state = A;
        end
        D: begin
            if (in)
                next_state = B;
            else
                next_state = C;
        end
    endcase
end

always @(*) begin
    out = (state == D);
end

endmodule
