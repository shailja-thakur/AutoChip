module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [3:0] {
        A    = 4'd0,
        B    = 4'd1,
        S0   = 4'd2,
        S1   = 4'd3,
        S10  = 4'd4,
        G1   = 4'd5,
        G2   = 4'd6,
        P0   = 4'd7,
        P1   = 4'd8
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or negedge resetn) begin
        if (~resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            A:   next_state = B;
            B:   next_state = S0;
            S0:  next_state = (x) ? S1 : S0;
            S1:  next_state = (x) ? S1 : S10;
            S10: next_state = (x) ? G1 : S0;
            G1:  next_state = (y) ? P1 : G2;
            G2:  next_state = (y) ? P1 : P0;
            P0:  next_state = P0;
            P1:  next_state = P1;
            default: next_state = A;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            f <= 1'b0;
            g <= 1'b0;
        end
        else begin
            case (state)
                B:  f <= 1'b1;
                default: f <= 1'b0;
            endcase

            case (state)
                G1, G2, P1: g <= 1'b1;
                default: g <= 1'b0;
            endcase
        end
    end

endmodule
