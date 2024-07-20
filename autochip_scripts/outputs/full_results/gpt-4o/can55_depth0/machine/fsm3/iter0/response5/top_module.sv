module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Enumeration for states
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    // State register
    reg [1:0] state, next_state;

    // Sequential logic for state register update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset to state A
        else
            state <= next_state; // Update state to next state
    end

    // Combinational logic for next state
    always @(*) begin
        case(state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A; // Default state
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == D)
            out = 1;
        else
            out = 0;
    end

endmodule
