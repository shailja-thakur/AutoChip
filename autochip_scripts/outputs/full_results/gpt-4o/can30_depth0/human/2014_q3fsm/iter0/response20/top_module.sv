module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;
    
    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            A: if (s) next_state = B;
            B: next_state = C;
            C: next_state = D;
            D: next_state = E;
            E: next_state = (w_count == 2) ? F : B;
            F: next_state = B;
        endcase
    end

    // W counter logic
    always_ff @(posedge clk) begin
        if (state == B)
            w_count <= 0;
        else if (state == C || state == D || state == E)
            w_count <= w_count + w;
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset)
            z <= 0;
        else if (state == F)
            z <= 1;
        else
            z <= 0;
    end

endmodule
