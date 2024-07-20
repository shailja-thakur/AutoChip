module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Reset state A
        z <= 0;
    end else begin
        case (state)
            2'b00: begin // State A
                if (s == 0)
                    state <= 2'b00; // Remain in state A
                else
                    state <= 2'b01; // Move to state B
            end
            2'b01: begin // State B
                if (w == 1)
                    state <= 2'b10; // Move to state C
                else
                    state <= 2'b01; // Remain in state B
            end
            2'b10: begin // State C
                if (w == 1)
                    state <= 2'b11; // Move to state D
                else
                    state <= 2'b01; // Move back to state B
            end
            2'b11: begin // State D
                if (w == 1)
                    z <= 1; // Set output z to 1
                else
                    z <= 0; // Set output z to 0
                state <= 2'b01; // Move back to state B
            end
        endcase
    end
end

endmodule
