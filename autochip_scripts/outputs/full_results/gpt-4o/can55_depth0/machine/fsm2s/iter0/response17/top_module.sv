module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State definition
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @ (*) begin
        case (state)
            A: begin
                if (j) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (k) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            default: begin
                next_state = A; // Default to state A
            end
        endcase
    end

    // Output logic
    always @ (*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0; // Default to 0
        endcase
    end

endmodule
