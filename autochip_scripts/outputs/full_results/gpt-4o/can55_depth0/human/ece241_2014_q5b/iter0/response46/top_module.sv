module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

typedef enum reg[1:0] {A = 2'b01, B = 2'b10} state_t;
state_t state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @* begin
    case (state)
        A: begin
            z = x ? 1 : 0;
            next_state = x ? B : A;
        end
        B: begin
            z = x ? 0 : 1;
            next_state = B;
        end
        default: begin
            z = 0;
            next_state = A;
        end
    endcase
end

endmodule
