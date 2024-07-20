module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;  // Initial state is A
        else
            state <= next_state;
    end

    always @* begin
        case (state)
            3'b000: begin  // State A
                if (w)
                    next_state = 3'b001;  // Transition to state B
                else
                    next_state = 3'b000;  // Transition to state A
            end
            3'b001: begin  // State B
                if (w)
                    next_state = 3'b010;  // Transition to state C
                else
                    next_state = 3'b010;  // Transition to state D
            end
            3'b010: begin  // State C
                if (w)
                    next_state = 3'b101;  // Transition to state E
                else
                    next_state = 3'b010;  // Transition to state D
            end
            3'b011: begin  // State D
                if (w)
                    next_state = 3'b111;  // Transition to state F
                else
                    next_state = 3'b000;  // Transition to state A
            end
            3'b100: begin  // State E
                if (w)
                    next_state = 3'b100;  // Transition to state E
                else
                    next_state = 3'b011;  // Transition to state D
            end
            3'b101: begin  // State F
                if (w)
                    next_state = 3'b011;  // Transition to state C
                else
                    next_state = 3'b010;  // Transition to state D
            end
            default: begin
                next_state = 3'b000;  // Default transition to state A
            end
        endcase
    end

    assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
