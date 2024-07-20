module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= 2'b00; // Reset to state A
    else begin
        case (state)
            2'b00: // State A
                if (in)
                    state <= 2'b01; // Next state is B
                else
                    state <= 2'b00; // Remain in state A
            2'b01: // State B
                if (in)
                    state <= 2'b01; // Remain in state B
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

always @(*) begin
    if (state == 2'b11)
        out = 1'b1; // Set output to 1 when in state D
    else
        out = 1'b0;
end

endmodule
