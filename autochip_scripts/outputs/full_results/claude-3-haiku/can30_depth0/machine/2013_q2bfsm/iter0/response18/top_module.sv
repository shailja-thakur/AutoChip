module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [2:0] state, next_state;

localparam A = 3'd0,
           B = 3'd1,
           S0 = 3'd2,
           S1 = 3'd3,
           S10 = 3'd4,
           G1 = 3'd5,
           G2 = 3'd6,
           P0 = 3'd7,
           P1 = 3'd8;

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
        S0: begin
            if (x) next_state = S1;
            else next_state = S0;
        end
        S1: begin
            if (x) next_state = S1;
            else next_state = S10;
        end
        S10: begin
            if (x) next_state = G1;
            else next_state = S0;
        end
        G1: begin
            if (y) next_state = P1;
            else next_state = G2;
        end
        G2: begin
            if (y) next_state = P1;
            else next_state = P0;
        end
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
