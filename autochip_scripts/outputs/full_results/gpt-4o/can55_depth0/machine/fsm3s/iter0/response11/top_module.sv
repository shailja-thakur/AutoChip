module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            A: if (in) next_state = B; else next_state = A;
            B: if (in) next_state = B; else next_state = C;
            C: if (in) next_state = D; else next_state = A;
            D: if (in) next_state = B; else next_state = C;
            default: next_state = A; // Safe default state
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b0;
        else if (state == D)
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
