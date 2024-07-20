module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State declaration
    typedef enum logic [3:0] {
        A,
        B,
        S0,
        S1,
        S10,
        G1,
        G2,
        P0,
        P1
    } state_t;

    // State and output variables
    state_t current_state;
    state_t next_state;
    reg f_reg;
    reg g_reg;

    // Initial state assignment
    initial begin
        current_state = A;
        f_reg = 0;
        g_reg = 0;
    end

    // Sequential logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A;
            f_reg <= 0;
            g_reg <= 0;
        end else begin
            current_state <= next_state;
            f_reg <= (current_state == B);
            g_reg <= (current_state == G1 || current_state == G2 || current_state == P1);
        end
    end

    // State transition logic
    always @(current_state or x) begin
        case (current_state)
            A: next_state = B;
            B: next_state = S0;
            S0: next_state = (x) ? S1 : S0;
            S1: next_state = (x) ? S1 : S10;
            S10: next_state = (x) ? G1 : S0;
            G1: next_state = (y) ? P1 : G2;
            G2: next_state = (y) ? P1 : P0;
            default: next_state = current_state;
        endcase
    end

    // Combinational output assignments
    assign f = f_reg;
    assign g = g_reg;

endmodule
