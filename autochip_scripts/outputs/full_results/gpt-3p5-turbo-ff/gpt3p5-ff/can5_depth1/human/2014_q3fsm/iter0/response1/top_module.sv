module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;  // Define a 2-bit register to represent the state

// Create the finite state machine
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;  // Reset state A
        z <= 0;  // Reset output z
    end else begin
        case (state)
            2'b00: begin  // State A
                if (s) begin
                    state <= 2'b01; // Move to state B if s = 1
                end
            end
            2'b01: begin  // State B
                if (w) begin
                    state <= 2'b10;  // Move to next state
                end
            end
            2'b10: begin  // State C
                if (w) begin
                    state <= 2'b11;  // Move to next state
                end else begin
                    state <= 2'b01;  // Move back to state B
                end
            end
            2'b11: begin  // State D
                if (w) begin
                    z <= 1;  // Set output to 1 if w = 1 in exactly two clock cycles
                end
                state <= 2'b01;  // Move back to state B
            end
        endcase
    end
end

endmodule
