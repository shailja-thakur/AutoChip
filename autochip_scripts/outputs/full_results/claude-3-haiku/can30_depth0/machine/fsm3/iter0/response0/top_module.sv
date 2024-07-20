module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // Reset state to A
    end
    else begin
        case (state)
            2'b00: // State A
                if (in)
                    state <= 2'b01; // Next state is B
                else
                    state <= 2'b00; // Stay in state A
            2'b01: // State B
                if (in)
                    state <= 2'b01; // Stay in state B
                else
                    state <= 2'b10; // Next state is C
            2'b10: // State C
                if (in)
                    state <= 2'b11; // Next state is D
                else
                    state <= 2'b00; // Next state is A
            2'b11: // State D
                if (in)
                    state <= 2'b01; // Next state is B
                else
                    state <= 2'b10; // Next state is C
        endcase
    end
end

always @(state) begin
    if (state == 2'b11) // If in state D
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
