module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        A, B, C, D, E, F
    } state_t;
    
    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            A: if (!w) next_state = B; else next_state = A;
            B: if (w) next_state = D; else next_state = C;
            C: if (w) next_state = D; else next_state = E;
            D: if (w) next_state = A; else next_state = F;
            E: if (w) next_state = D; else next_state = E;
            F: if (w) next_state = D; else next_state = C;
            default: next_state = A;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 0;
        else 
            z <= (state == E || state == F);
    end

endmodule
