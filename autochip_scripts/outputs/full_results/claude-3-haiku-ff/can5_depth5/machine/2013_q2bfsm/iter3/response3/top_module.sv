module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [3:0] state, next_state;
parameter A = 0, B = 1, S0 = 2, S1 = 3, S10 = 4, G1 = 5, G2 = 6, P0 = 7, P1 = 8;

always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case(state)
        A: next_state = B;
        B: next_state = S0;
        S0: begin
            if(x) next_state = S1;
            else next_state = S0;
        end
        S1: begin
            if(x) next_state = S1;
            else next_state = S10;
        end
        S10: begin
            if(x) next_state = S1;
            else next_state = S0;
        end
        G1: begin
            if(y) next_state = P1;
            else next_state = G2;
        end
        G2: begin
            if(y) next_state = P1;
            else next_state = P0;
        end
        P0: next_state = P0;
        P1: next_state = P1;
    endcase
end

always @(*) begin
    f = 0;
    g = 0;
    case(state)
        B: f = 1;
        G1, G2, P1: g = 1;
    endcase
end

endmodule
