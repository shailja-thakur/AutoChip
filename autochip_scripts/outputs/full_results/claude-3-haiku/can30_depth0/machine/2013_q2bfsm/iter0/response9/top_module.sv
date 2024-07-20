module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam A = 0, B = 1, S0 = 2, S1 = 3, S10 = 4, G1 = 5, G2 = 6, P0 = 7, P1 = 8;
reg [3:0] state, next_state;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
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
