module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Reset state A
    end else begin
        case (state)
            // State A transitions
            2'b00: begin
                if (s) begin
                    state <= 2'b01; // Transition to state B
                end
            end
            // State B transitions
            2'b01: begin
                if (w) begin
                    state <= 2'b10; // Go to next state
                end
            end
            2'b10: begin
                if (w) begin
                    state <= 2'b11; // Go to next state
                end else begin
                    state <= 2'b01; // Go back to state B
                end
            end
            2'b11: begin
                if (w) begin
                    z <= 1; // Set output z to 1
                    state <= 2'b01; // Go back to state B
                end else begin
                    z <= 0; // Set output z to 0
                    state <= 2'b01; // Go back to state B
                end
            end
        endcase
    end
end

endmodule
