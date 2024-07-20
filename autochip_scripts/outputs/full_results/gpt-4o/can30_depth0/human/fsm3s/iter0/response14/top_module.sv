module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A; // Default state
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b0;
            C: out = 1'b0;
            D: out = 1'b1;
            default: out = 1'b0; // Default output
        endcase
    end

endmodule
