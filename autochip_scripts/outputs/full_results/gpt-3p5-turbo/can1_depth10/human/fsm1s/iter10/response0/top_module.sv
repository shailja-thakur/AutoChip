module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    reg [1:0] state;
    reg reset_sync;

    always @(posedge clk) begin
        // Synchronous reset
        if (reset)
            reset_sync <= 1'b1;
        else
            reset_sync <= 1'b0;

        if (reset_sync)
            state <= 2'b01; // Reset state B
        else begin
            case(state)
                2'b00: // State A
                    if (!in)
                        state <= 2'b01; // Transition to state B
                2'b01: // State B
                    if (in)
                        state <= 2'b00; // Transition to state A
                    else
                        state <= 2'b01; // Stay in state B
                default:
                    state <= 2'b01; // Default to state B
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
