module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [2:0] state, next_state;
parameter A = 3'd0, B = 3'd1, S0 = 3'd2, S1 = 3'd3, S10 = 3'd4, G1 = 3'd5, G2 = 3'd6, P0 = 3'd7, P1 = 3'd7;

always @(posedge clk) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: next_state = B;
        B: next_state = S0;
        S0: next_state = (x) ? S1 : S0;
        S1: next_state = (x) ? S1 : S10;
        S10: next_state = (x) ? G1 : S0;
        G1: next_state = (y) ? P1 : G2;
        G2: next_state = (y) ? P1 : P0;
        P0: next_state = P0;
        P1: next_state = P1;
        default: next_state = A;
    endcase
end

always @(*) begin
    f = 0;
    g = 0;
    case (state)
        B: f = 1;
        G1, G2, P1: g = 1;
    endcase
end

endmodule
