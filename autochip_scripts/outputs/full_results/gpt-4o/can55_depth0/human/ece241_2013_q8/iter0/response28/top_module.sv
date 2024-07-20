module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // Detected 1
        S2 = 2'b10  // Detected 10
    } state_t;
    state_t state, next_state;

    // State Transition Logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Next State Logic and Output Logic
    always @(*) begin
        // Default assignments
        next_state = state;
        z = 1'b0;

        case (state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (!x)
                    next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1;
                end else begin
                    next_state = S0;
                end
            end
            default: next_state = S0;
        endcase
    end

endmodule
