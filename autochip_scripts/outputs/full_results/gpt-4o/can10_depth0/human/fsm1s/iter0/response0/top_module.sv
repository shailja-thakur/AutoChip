module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            B: if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            A: if (in) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            default: next_state = B; // Default state should always be defined.
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1; // Default output value
        endcase
    end

endmodule
