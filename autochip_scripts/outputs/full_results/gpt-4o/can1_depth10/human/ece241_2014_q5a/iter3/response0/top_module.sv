module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    localparam S0 = 1'b0;  // Initial state
    localparam S1 = 1'b1;  // Inverting state

    reg state, next_state;

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
                if (x == 1'b0)
                    next_state = S0;
                else
                    next_state = S1;
            end
            S1: begin
                next_state = S1;
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            z <= 1'b0; // Reset output
        else begin
            case(state)
                S0: z <= x;      // Output same as input in initial state
                S1: z <= ~x;     // Inverting the bit
                default: z <= x;
            endcase
        end
    end

endmodule
