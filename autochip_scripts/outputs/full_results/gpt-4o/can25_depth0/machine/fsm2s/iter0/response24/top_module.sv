module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define state constants
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    // State registers
    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;  // Initialize to state A on reset
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
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
                next_state = A;   // Default state is A
            end
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
endmodule
