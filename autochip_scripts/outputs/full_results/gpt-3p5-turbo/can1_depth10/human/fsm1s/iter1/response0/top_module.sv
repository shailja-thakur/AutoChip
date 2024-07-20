module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b10; // Reset state B
        else begin
            case(state)
                2'b00: // State A
                    if (in)
                        state <= 2'b01; // Transition to state A
                    else
                        state <= 2'b00; // Transition to state B
                2'b01: // State B
                    if (in)
                        state <= 2'b01; // Stay in state B
                    else
                        state <= 2'b10; // Transition to state A
                default:
                    state <= 2'b10; // Default to state B
            endcase
        end
    end
    
    always @(state) begin
        case(state)
            2'b00: // State A
                out <= 1'b0; // Output 0
            2'b01: // State B
                out <= 1'b1; // Output 1
            default:
                out <= 1'b1; // Default to output 1
        endcase
    end

endmodule
