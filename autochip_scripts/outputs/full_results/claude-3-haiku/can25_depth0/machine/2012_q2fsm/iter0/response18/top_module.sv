module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

localparam [2:0] A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: next_state = (w == 1'b0) ? A : B;
        B: next_state = (w == 1'b0) ? D : C;
        C: next_state = (w == 1'b0) ? D : E;
        D: next_state = (w == 1'b0) ? A : F;
        E: next_state = (w == 1'b0) ? D : E;
        F: next_state = (w == 1'b0) ? D : C;
        default: next_state = A;
    endcase
end

always @(*) begin
    z = (state == E || state == F) ? 1'b1 : 1'b0;
end

endmodule
