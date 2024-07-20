module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= B;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            out = 1'b0;
            if (in)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            out = 1'b1;
            if (in)
                next_state = B;
            else
                next_state = A;
        end
        default: begin
            out = 1'b0;
            next_state = A;
        end
    endcase
end

endmodule
