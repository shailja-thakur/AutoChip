module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter A = 2'b01;
parameter B = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(state, x) begin
    case (state)
        A: begin
            if (x)
                next_state = B;
            else
                next_state = A;
            z = x;
        end
        B: begin
            next_state = B;
            z = ~x;
        end
        default: begin
            next_state = A;
            z = 1'b0;
        end
    endcase
end

endmodule
