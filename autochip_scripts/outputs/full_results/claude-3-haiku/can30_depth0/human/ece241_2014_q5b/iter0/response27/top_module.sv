module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter A = 2'b01, B = 2'b10;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (x == 0)
                next_state = A;
            else
                next_state = B;
            z = x;
        end
        B: begin
            if (x == 0)
                next_state = B;
            else
                next_state = B;
            z = ~x;
        end
        default: begin
            next_state = A;
            z = 0;
        end
    endcase
end

endmodule
