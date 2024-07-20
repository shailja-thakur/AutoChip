module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;
    
    // State register
    always @(posedge clk or negedge reset) begin
        if (!reset)
            state <= 3'b000; // State A
        else begin
            case (state)
                3'b000: // State A
                    if (w == 0)
                        state <= 3'b000; // Transition to A
                    else
                        state <= 3'b001; // Transition to B
                3'b001: // State B
                    if (w == 0)
                        state <= 3'b011; // Transition to D
                    else
                        state <= 3'b010; // Transition to C
                3'b010: // State C
                    if (w == 0)
                        state <= 3'b011; // Transition to D
                    else
                        state <= 3'b100; // Transition to E
                3'b011: // State D
                    if (w == 0)
                        state <= 3'b000; // Transition to A
                    else
                        state <= 3'b101; // Transition to F
                3'b100: // State E
                    if (w == 0)
                        state <= 3'b011; // Transition to D
                    else
                        state <= 3'b100; // Transition to E
                3'b101: // State F
                    if (w == 0)
                        state <= 3'b011; // Transition to D
                    else
                        state <= 3'b010; // Transition to C
            endcase
        end
    end

    // Output logic
    always @* begin
        case (state)
            3'b100: // State E
                z = 1'b1;
            3'b101: // State F
                z = 1'b1;
            default:
                z = 1'b0;
        endcase
    end

endmodule
