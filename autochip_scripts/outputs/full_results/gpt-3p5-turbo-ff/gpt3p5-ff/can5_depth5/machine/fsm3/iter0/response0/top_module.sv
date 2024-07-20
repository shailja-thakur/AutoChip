module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state;
reg out_reg;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // Reset to state A
    else begin
        case (state)
            2'b00: // State A
                if (in)
                    state <= 2'b01; // Next state B if in=1, else A
                else
                    state <= 2'b00; // Next state A if in=0

            2'b01: // State B
                if (in)
                    state <= 2'b01; // Next state B if in=1, else C
                else
                    state <= 2'b10; // Next state C if in=0

            2'b10: // State C
                if (in)
                    state <= 2'b11; // Next state D if in=1, else A
                else
                    state <= 2'b00; // Next state A if in=0

            2'b11: // State D
                if (in)
                    state <= 2'b01; // Next state B if in=1, else C
                else
                    state <= 2'b10; // Next state C if in=0
        endcase
    end
end

always @(state) begin
    if (state == 2'b11)
        out_reg = 1'b1; // Set out to 1 when in state D
    else
        out_reg = 1'b0;
end

assign out = out_reg;

endmodule
