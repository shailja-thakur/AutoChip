module top_module(
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= 3'b000;
        else
        begin
            case (state)
                3'b000: // State A
                    if (w)
                        state <= 3'b001; // Transition to state B
                    else
                        state <= 3'b000; // Stay in state A
                3'b001: // State B
                    if (w)
                        state <= 3'b010; // Transition to state D
                    else
                        state <= 3'b011; // Transition to state A
                3'b010: // State C
                    if (w)
                        state <= 3'b010; // Stay in state C
                    else
                        state <= 3'b100; // Transition to state E
                3'b011: // State D
                    if (w)
                        state <= 3'b101; // Transition to state F
                    else
                        state <= 3'b001; // Transition to state B
                3'b100: // State E
                    if (w)
                        state <= 3'b101; // Transition to state F
                    else
                        state <= 3'b010; // Stay in state C
				3'b101: // State F
                    if (w)
                        state <= 3'b100; // Transition to state E
                    else
                        state <= 3'b011; // Transition to state D
				default:
                    state <= 3'b000;
            endcase
        end
    end

    always @(state)
    begin
        case (state)
            3'b000: z = 1'b0;
            3'b001: z = 1'b0;
            3'b010: z = 1'b0;
            3'b011: z = 1'b0;
            3'b100: z = 1'b1;
            3'b101: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
