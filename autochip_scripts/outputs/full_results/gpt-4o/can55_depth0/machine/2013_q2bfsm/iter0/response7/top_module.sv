module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [3:0] {
        A = 4'b0000,
        B = 4'b0001,
        S0 = 4'b0010,
        S1 = 4'b0011,
        S10 = 4'b0100,
        G1 = 4'b0101,
        G2 = 4'b0110,
        P0 = 4'b0111,
        P1 = 4'b1000
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        f = 1'b0;
        g = 1'b0;
        case (state)
            A: next_state = B;
            B: begin
                next_state = S0;
                f = 1'b1;
            end
            S0: if (x) next_state = S1;
            S1: if (x) next_state = S1; else next_state = S10;
            S10: if (x) next_state = G1; else next_state = S0;
            G1: begin
				if (y) next_state = P1; else next_state = G2;
                g = 1'b1;
			end
            G2: begin
				if (y) next_state = P1; else next_state = P0;
                g = 1'b1;
			end
            P0: next_state = P0;
            P1: begin
                g = 1'b1;
                next_state = P1;
            end
            default: next_state = A;
        endcase
    end

endmodule
