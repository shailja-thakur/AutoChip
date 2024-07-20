module fsm (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define FSM states
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

    // Define current state and next state
    state_t current_state;
    state_t next_state;

    // Assign initial state
    initial begin
        current_state = A;
        f = 0;
        g = 0;
    end
    
    // FSM transition and output logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A;
            f <= 0;
            g <= 0;
        end else begin
            current_state <= next_state;
            case (current_state)
                A: begin
                    if (x)
                        next_state = B;
                    else
                        next_state = S0;
                    f = 0;
                    g = 0;
                end
                B: begin
                    next_state = S0;
                    f = 1;
                    g = 0;
                end
                S0: begin
                    if (x)
                        next_state = S1;
                    else
                        next_state = S0;
                    f = 0;
                    g = 0;
                end
                S1: begin
                    if (x)
                        next_state = S1;
                    else
                        next_state = S10;
                    f = 0;
                    g = 0;
                end
                S10: begin
                    if (x)
                        next_state = G1;
                    else
                        next_state = S0;
                    f = 0;
                    g = 0;
                end
                G1: begin
                    if (y)
                        next_state = P1;
                    else
                        next_state = G2;
                    f = 0;
                    g = 1;
                end
                G2: begin
                    if (y)
                        next_state = P1;
                    else
                        next_state = P0;
                    f = 0;
                    g = 1;
                end
                P0: begin
                    next_state = P0;
                    f = 0;
                    g = 0;
                end
                P1: begin
                    next_state = P1;
                    f = 0;
                    g = 1;
                end
                default: begin
                    next_state = A;
                    f = 0;
                    g = 0;
                end
            endcase
        end
    end

endmodule
module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);
    
    fsm fsm_inst (
        .clk(clk),
        .resetn(resetn),
        .x(x),
        .y(y),
        .f(f),
        .g(g)
    );

endmodule
