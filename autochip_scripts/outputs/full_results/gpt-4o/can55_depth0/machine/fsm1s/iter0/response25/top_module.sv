module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // Combinational logic for state transition
    always_comb begin
        case (state)
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            default: next_state = B; // Default to B in case of unknown state
        endcase
    end

    // Sequential logic for state update
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to initial state B
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
