module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial state / start state
        S1 = 2'b01, // State for propagating bits before first 1 is detected
        S2 = 2'b10  // State for inverting bits after first 1 is detected
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: begin
                if (x)
                    next_state = S2;
                else
                    next_state = S1;
            end
            S1: begin
                if (x)
                    next_state = S2;
                else
                    next_state = S1;
            end
            S2: begin
                next_state = S2;
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            z <= 1'b0;
        else begin
            case (state)
                S0: z <= x;    // Start state, pass input directly to output
                S1: z <= x;    // Propagate bits before first 1 is detected
                S2: z <= ~x;   // Invert bits after first 1 is detected
                default: z <= x;
            endcase
        end
    end

endmodule
