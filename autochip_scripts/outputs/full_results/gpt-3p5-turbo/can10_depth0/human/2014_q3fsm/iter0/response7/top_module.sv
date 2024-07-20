module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state; // state variable

always @(posedge clk) begin
    // Synchronous reset
    if (reset) begin
        state <= 2'b00; // Reset state A
    end else begin
        case (state)
            2'b00: begin // State A
                if (s) begin // Transition to state B when s = 1
                    state <= 2'b01; // State B
                end
            end
            2'b01: begin // State B
                if (w) begin
                    state <= 2'b10; // Move to next state after one clock cycle
                end
            end
            2'b10: begin // State B continued
                if (w) begin
                    state <= 2'b11; // Move to next state after two clock cycles
                end else begin
                    state <= 2'b01; // Return to state B if w = 0
                end
            end
            2'b11: begin // State B continued
                if (w) begin
                    state <= 2'b00; // Return to state A after three clock cycles if w = 1 in exactly two of them
                    z <= 1; // Set output z to 1
                end else begin
                    state <= 2'b01; // Return to state B if w = 0
                    z <= 0; // Set output z to 0
                end
            end
        endcase
    end
end

endmodule
