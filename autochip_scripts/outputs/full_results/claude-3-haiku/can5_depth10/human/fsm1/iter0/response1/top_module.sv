module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

localparam A = 1'b0, B = 1'b1;
reg state, next_state;

always @(*) begin
    case (state)
        B: begin
            if (in) next_state = B;
            else next_state = A;
        end
        A: begin
            if (in) next_state = A;
            else next_state = B;
        end
        default: next_state = B;
    endcase
end

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= B;
    else
        state <= next_state;
end

always @(state) begin
    case (state)
        A: out = 0;
        B: out = 1;
        default: out = 0;
    endcase
end

endmodule
