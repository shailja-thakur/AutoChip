module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // State A
    end
    else begin
        case (state)
            3'b000: // State A
                if (w == 1'b0) begin
                    state <= 3'b000; // Stay in State A
                end
                else begin
                    state <= 3'b001; // Transition to State B
                end
            3'b001: // State B
                if (w == 1'b0) begin
                    state <= 3'b011; // Transition to State D
                end
                else begin
                    state <= 3'b010; // Transition to State C
                end
            3'b010: // State C
                if (w == 1'b0) begin
                    state <= 3'b011; // Transition to State D
                end
                else begin
                    state <= 3'b100; // Transition to State E
                end
            3'b011: // State D
                if (w == 1'b0) begin
                    state <= 3'b000; // Transition to State A
                end
                else begin
                    state <= 3'b101; // Transition to State F
                end
            3'b100: // State E
                if (w == 1'b0) begin
                    state <= 3'b011; // Transition to State D
                end
                else begin
                    state <= 3'b100; // Stay in State E
                end
            3'b101: // State F
                if (w == 1'b0) begin
                    state <= 3'b011; // Transition to State D
                end
                else begin
                    state <= 3'b010; // Transition to State C
                end
            default:
                state <= 3'b000; // Reset to State A
        endcase
    end
end

always @(*) begin
    z = (state == 3'b100 || state == 3'b101); // Set z to 1 when in State E or F
end

endmodule
