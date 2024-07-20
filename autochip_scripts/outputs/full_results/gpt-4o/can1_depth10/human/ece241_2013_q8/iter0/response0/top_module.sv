module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // After seeing '1'
        S2 = 2'b10  // After seeing '10'
    } state_t;

    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            S0: begin
                if (x) next_state = S1;
                else next_state = S0;
            end

            S1: begin
                if (x) next_state = S1;
                else next_state = S2;
            end

            S2: begin
                if (x) next_state = S1;
                else next_state = S0;
            end

            default: next_state = S0;
        endcase
    end

    // State register
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            S0: z = 1'b0;
            S1: z = 1'b0;
            S2: z = x; // Assert z when the sequence "101" is detected
            default: z = 1'b0;
        endcase
    end

endmodule
