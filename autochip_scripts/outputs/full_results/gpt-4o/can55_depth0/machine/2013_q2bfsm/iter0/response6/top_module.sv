module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State declaration
    typedef enum logic [2:0] {
        A   = 3'b000,
        B   = 3'b001,
        S0  = 3'b010,
        S1  = 3'b011,
        S10 = 3'b100,
        G1  = 3'b101,
        G2  = 3'b110,
        P0  = 3'b111,
        P1  = 3'b1000
    } state_t;
    state_t state, next_state;

    // Sequential logic: State transition on clock edge
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Combinational logic: Next state logic
    always_comb begin
        // Default assignments
        next_state = state;
        f = 0;
        g = 0;
        case (state)
            A: next_state = B;
            B: begin
                next_state = S0;
                f = 1;
            end
            S0: if (x) next_state = S1;
                 else next_state = S0;
            S1: if (x) next_state = S1;
                 else next_state = S10;
            S10: if (x) next_state = G1;
                  else next_state = S0;
            G1: begin
                g = 1;
                if (y) next_state = P1;
                 else next_state = G2;
            end
            G2: begin
                g = 1;
                if (y) next_state = P1;
                 else next_state = P0;
            end
            P0: begin
                g = 1;
                next_state = P0;
            end
            P1: begin
                g = 1;
                next_state = P1;
            end
            default: next_state = A;
        endcase
    end

endmodule
