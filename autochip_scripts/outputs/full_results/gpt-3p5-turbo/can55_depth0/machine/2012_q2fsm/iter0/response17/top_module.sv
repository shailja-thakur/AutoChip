module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // Initial state is A
    else
        state <= next_state;
end

always @(state or w) begin
    case (state)
        3'b000: begin // State A
            if (w)
                next_state = 3'b001; // Transition to B if w = 1
            else
                next_state = 3'b000; // Transition to A if w = 0
        end

        3'b001: begin // State B
            if (w)
                next_state = 3'b010; // Transition to C if w = 1
            else
                next_state = 3'b100; // Transition to D if w = 0
        end

        3'b010: begin // State C
            if (w)
                next_state = 3'b101; // Transition to E if w = 1
            else
                next_state = 3'b100; // Transition to D if w = 0
        end

        3'b100: begin // State D
            if (w)
                next_state = 3'b111; // Transition to F if w = 1
            else
                next_state = 3'b000; // Transition to A if w = 0
        end

        3'b101: next_state = 3'b101; // State E (no change)

        3'b111: next_state = 3'b010; // State F (Transition to C)

        default: next_state = 3'b000;
    endcase
end

assign z = (state == 3'b101 || state == 3'b111) ? 1'b1 : 1'b0;

endmodule
