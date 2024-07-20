module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State declarations
    typedef enum reg { A, B } state_t;
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A; // default to A for safety
        endcase
    end

    // State register and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            out <= 0;
        end else begin
            current_state <= next_state;
            out <= (next_state == B);
        end
    end

endmodule
