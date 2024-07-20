module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

// State definitions
localparam A = 2'b00, B = 2'b01, S0 = 2'b10, S1 = 2'b11, S10 = 3'b100, G1 = 3'b101, G2 = 3'b110, P0 = 3'b111, P1 = 4'b1000;

reg [3:0] state, next_state;

// Next state logic
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

// Output logic
always @(*) begin
    f = 0;
    g = 0;
    case (state)
        B: f = 1;
        G1, G2, P1: g = 1;
    endcase
end

// State update logic
always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= A;
    else
        state <= next_state;
end

endmodule
