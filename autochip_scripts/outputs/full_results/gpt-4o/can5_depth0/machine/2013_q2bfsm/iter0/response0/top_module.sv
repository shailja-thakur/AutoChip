module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    // State encoding
    typedef enum reg [3:0] {
        A = 4'd0,
        B = 4'd1,
        S0 = 4'd2,
        S1 = 4'd3,
        S10 = 4'd4,
        G1 = 4'd5,
        G2 = 4'd6,
        P0 = 4'd7,
        P1 = 4'd8
    } state_t;

    state_t state, next_state;

    // State register
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always_comb begin
        f = 1'b0; // Default output
        g = 1'b0; // Default output
        case (state)
            A: begin
                next_state = B;
            end
            B: begin
                next_state = S0;
                f = 1'b1;
            end
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S10;
            end
            S10: begin
                if (x)
                    next_state = G1;
                else
                    next_state = S0;
            end
            G1: begin
                if (y)
                    next_state = P1;
                else
                    next_state = G2;
                g = 1'b1;
            end
            G2: begin
                if (y)
                    next_state = P1;
                else
                    next_state = P0;
                g = 1'b1;
            end
            P0: begin
                next_state = P0;
            end
            P1: begin
                next_state = P1;
                g = 1'b1;
            end
            default: begin
                next_state = A;
            end
        endcase
    end
endmodule
