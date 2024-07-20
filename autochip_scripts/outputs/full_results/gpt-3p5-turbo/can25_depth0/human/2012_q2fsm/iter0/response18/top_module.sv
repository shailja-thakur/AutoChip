module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    reg [2:0] state;

    // State updates based on input and current state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Reset state A
        end else begin
            case (state)
                3'b000: // State A
                    if (w)
                        state <= 3'b001; // Transition to state B
                    else
                        state <= 3'b000; // Stay in state A
                3'b001: // State B
                    if (w)
                        state <= 3'b010; // Transition to state C
                    else
                        state <= 3'b011; // Transition to state D
                3'b010: // State C
                    if (w)
                        state <= 3'b100; // Transition to state E
                    else
                        state <= 3'b011; // Transition to state D
                3'b011: // State D
                    if (w)
                        state <= 3'b101; // Transition to state F
                    else
                        state <= 3'b000; // Transition to state A
                3'b100: // State E
                    if (w)
                        state <= 3'b100; // Stay in state E
                    else
                        state <= 3'b011; // Transition to state D
                3'b101: // State F
                    if (w)
                        state <= 3'b010; // Transition to state C
                    else
                        state <= 3'b011; // Transition to state D
                default: state <= 3'b000; // Default transition to state A
            endcase
        end
    end

    // Output assignment
    always @(state) begin
        case (state)
            3'b000: z = 1'b0; // Output z is 0 in state A
            3'b001: z = 1'b0; // Output z is 0 in state B
            3'b010: z = 1'b1; // Output z is 1 in state C
            3'b011: z = 1'b0; // Output z is 0 in state D
            3'b100: z = 1'b1; // Output z is 1 in state E
            3'b101: z = 1'b1; // Output z is 1 in state F
            default: z = 1'b0; // Default output z is 0 in case of unknown state
        endcase
    end

endmodule
