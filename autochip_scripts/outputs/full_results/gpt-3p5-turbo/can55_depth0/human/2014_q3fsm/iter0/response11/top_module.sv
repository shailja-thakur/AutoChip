module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b0; // Reset state A
        z <= 0;
    end else begin
        case (state)
            2'b00: begin // State A
                if (s == 1) begin
                    state <= 2'b01; // Transition to state B
                end else begin
                    state <= 2'b00; // Remain in state A
                end
                z <= 0;
            end
            2'b01, 2'b10, 2'b11: begin // State B
                if (w == 1) begin
                    state <= state + 1; // Stay in state B
                end else begin
                    state <= state - 1; // Return to state A
                end
                
                if (state == 3) begin
                    z <= 1; // Set output to 1 if w == 1 in exactly two of the next three clock cycles
                end else begin
                    z <= 0; // Set output to 0 otherwise
                end
            end
        endcase
    end
end

endmodule
