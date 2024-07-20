module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State declaration
    typedef enum reg [2:0] {A, B, C, D, E, F} state_t;
    state_t state, next_state;

    // State transition on clk edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (w)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (w)
                    next_state = D;
                else
                    next_state = C;
            end
            C: begin
                if (w)
                    next_state = D;
                else
                    next_state = E;
            end
            D: begin
                if (w)
                    next_state = A;
                else
                    next_state = F;
            end
            E: begin
                if (w)
                    next_state = D;
                else
                    next_state = E;
            end
            F: begin
                if (w)
                    next_state = D;
                else
                    next_state = C;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end

endmodule
