module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

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

    // State transition
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            A:   next_state = B;
            B:   next_state = S0;
            S0:  next_state = (x ? S1 : S0);
            S1:  next_state = (x ? S1 : S10);
            S10: next_state = (x ? G1 : S0);
            G1:  next_state = (y ? P1 : G2);
            G2:  next_state = (y ? P1 : P0);
            P0:  next_state = P0;
            P1:  next_state = P1;
            default: next_state = A;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
        end else begin
            f <= (state == B);
            g <= (state == G1) || (state == G2) || (state == P1);
        end
    end

endmodule
