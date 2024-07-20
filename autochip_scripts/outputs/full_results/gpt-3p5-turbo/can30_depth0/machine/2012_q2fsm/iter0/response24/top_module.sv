module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
reg next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // Initial state is A
    else begin
        case (state)
            3'b000: begin // State A
                if (w)
                    next_state = 3'b001; // Transition to B
                else
                    next_state = 3'b000; // Transition to A
            end
            3'b001: begin // State B
                if (w)
                    next_state = 3'b010; // Transition to C
                else
                    next_state = 3'b100; // Transition to D
            end
            3'b010: begin // State C
                if (w)
                    next_state = 3'b111; // Transition to E
                else
                    next_state = 3'b100; // Transition to D
            end
            3'b100: begin // State D
                if (w)
                    next_state = 3'b011; // Transition to F
                else
                    next_state = 3'b000; // Transition to A
            end
            3'b111: begin // State E
                if (w)
                    next_state = 3'b111; // Transition to E
                else
                    next_state = 3'b100; // Transition to D
            end
            3'b011: begin // State F
                if (w)
                    next_state = 3'b010; // Transition to C
                else
                    next_state = 3'b100; // Transition to D
            end
        endcase
        state <= next_state;
    end
end

assign z = (state == 3'b111) || (state == 3'b011);

endmodule
