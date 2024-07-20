module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            A: begin
                if (x) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                if (x) 
                    next_state = E;
                else 
                    next_state = B;
            end
            C: begin
                if (x) 
                    next_state = B;
                else 
                    next_state = C;
            end
            D: begin
                if (x) 
                    next_state = C;
                else 
                    next_state = B;
            end
            E: begin
                if (x) 
                    next_state = E;
                else 
                    next_state = D;
            end
            default: next_state = A; // Default to state A for undefined states
        endcase
    end

    // State Register Logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Output Logic
    always @(state) begin
        case (state)
            D,
            E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
