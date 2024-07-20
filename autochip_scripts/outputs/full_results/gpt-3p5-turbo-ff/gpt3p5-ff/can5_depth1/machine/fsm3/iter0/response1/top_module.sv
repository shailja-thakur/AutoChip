module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state;
wire [1:0] next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // reset to state A
    else
        state <= next_state; // update state based on next_state
end

assign out = (state == 2'b11); // set out to 1 when state is D

assign next_state = (state == 2'b00 && in) ? 2'b01  // state A transitions
                : (state == 2'b01 && in) ? 2'b01  // state B transitions
                : (state == 2'b01 && !in) ? 2'b10 // state B transitions
                : (state == 2'b10 && in) ? 2'b11  // state C transitions
                : (state == 2'b10 && !in) ? 2'b00 // state C transitions
                : (state == 2'b11 && in) ? 2'b01  // state D transitions
                : 2'b10; // state D transitions

endmodule
