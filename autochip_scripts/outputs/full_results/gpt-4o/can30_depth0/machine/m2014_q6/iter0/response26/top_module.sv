module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (current_state)
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
        case (current_state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
