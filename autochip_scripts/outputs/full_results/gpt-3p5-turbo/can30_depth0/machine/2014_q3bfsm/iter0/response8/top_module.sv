module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000; // Initialize state to A on reset
        else begin
            case (state)
                3'b000: // State A
                    if (x)
                        state <= 3'b001; // Transition to state B
                    else
                        state <= 3'b000; // Stay in state A
                3'b001: // State B
                    if (x)
                        state <= 3'b100; // Transition to state E
                    else
                        state <= 3'b001; // Stay in state B
                3'b010: // State C
                    if (x)
                        state <= 3'b001; // Transition to state B
                    else
                        state <= 3'b010; // Stay in state C
                3'b011: // State D
                    if (x)
                        state <= 3'b010; // Transition to state C
                    else
                        state <= 3'b001; // Stay in state B
                3'b100: // State E
                    if (x)
                        state <= 3'b100; // Stay in state E
                    else
                        state <= 3'b011; // Transition to state D
                default:
                    state <= 3'b000; // Default to state A
            endcase
        end
    end

    always @(state) begin
        case (state)
            3'b011: // State D
            3'b100: // State E
                z = 1; // Output is high in states D and E
            default:
                z = 0; // Output is low in all other states
        endcase
    end

endmodule
