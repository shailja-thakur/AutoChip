module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state; // 3-bit register to hold the current state

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // Initial state is A
    end else begin
        case (state)
            3'b00: begin // State A
                if (w) begin
                    state <= 3'b01; // Transition from A to B
                end else begin
                    state <= 3'b00; // Stay in state A
                end
            end
            
            3'b01: begin // State B
                if (w) begin
                    state <= 3'b10; // Transition from B to C
                end else begin
                    state <= 3'b11; // Transition from B to D
                end
            end
            
            3'b10: begin // State C
                if (w) begin
                    state <= 3'b10; // Stay in state C
                end else begin
                    state <= 3'b11; // Transition from C to D
                end
            end
            
            3'b11: begin // State D
                if (w) begin
                    state <= 3'b11; // Stay in state D
                end else begin
                    state <= 3'b00; // Transition from D to A
                end
            end
        endcase
    end
end

// Assign output z to 1 when state is E or F
always @(state) begin
    if (state == 3'b10 || state == 3'b11) begin
        z <= 1;
    end else begin
        z <= 0;
    end
end

endmodule
