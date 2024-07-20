module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [3:0] state, next_state;
parameter A = 4'd0, B = 4'd1, S0 = 4'd2, S1 = 4'd3, S10 = 4'd4, G1 = 4'd5, G2 = 4'd6, P0 = 4'd7, P1 = 4'd8;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
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
        default: next_state = A;
    endcase
end

always @(*) begin
    f = 1'b0;
    g = 1'b0;
    case (state)
        B: f = 1'b1;
        G1, G2, P1: g = 1'b1;
    endcase
end

endmodule
