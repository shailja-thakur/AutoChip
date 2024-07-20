module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    reg [2:0] state, next_state;  // Changed logic type to reg

    // State transition logic
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
            default: next_state = A; // Default state
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        case (state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end
endmodule
