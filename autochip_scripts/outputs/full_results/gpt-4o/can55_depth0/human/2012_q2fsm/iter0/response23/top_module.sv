module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // State encodings
    typedef enum logic [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;

    state_t current_state, next_state;

    // State flip-flops
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // State table
    always_comb begin
        case (current_state)
            A: if (w) next_state = B;
               else   next_state = A;
            B: if (w) next_state = C;
               else   next_state = D;
            C: if (w) next_state = E;
               else   next_state = D;
            D: if (w) next_state = F;
               else   next_state = A;
            E: if (w) next_state = E;
               else   next_state = D;
            F: if (w) next_state = C;
               else   next_state = D;
            default: next_state = A;
        endcase
    end

    // Output logic
    assign z = (current_state == E || current_state == F);

endmodule
