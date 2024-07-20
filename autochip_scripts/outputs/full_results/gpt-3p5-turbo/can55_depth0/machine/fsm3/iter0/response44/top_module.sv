module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state;
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00;  // Reset to state A
    else begin
        case (state)
            2'b00: if (in) state <= 2'b01; else state <= 2'b00;  // Transition from state A to B or stay in A
            2'b01: if (in) state <= 2'b01; else state <= 2'b10;  // Transition from state B to B or C
            2'b10: if (in) state <= 2'b11; else state <= 2'b00;  // Transition from state C to D or A
            2'b11: if (in) state <= 2'b01; else state <= 2'b10;  // Transition from state D to B or C
        endcase
    end
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;  // Output is 1 when in state D
endmodule
