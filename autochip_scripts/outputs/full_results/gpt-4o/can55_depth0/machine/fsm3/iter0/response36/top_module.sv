module top_module (
    input clk,
    input in,
    input areset,
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

    // Update the state on the rising edge of clk or areset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;  // Reset state to A
        else 
            state <= next_state;
    end

    // Determine next state based on current state and input signal
    always_comb begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;  // Default next state
        endcase
    end

    // Set output based on current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;
        else
            out <= (state == D);
    end

endmodule
