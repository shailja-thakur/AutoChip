module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01;  // state B
    else if (state == 2'b00) begin  // state A
        if (in)
            state <= state;  // stay in state A
        else
            state <= 2'b01;  // transition to state B
    end else begin  // state B
        if (in)
            state <= state;  // stay in state B
        else
            state <= 2'b00;  // transition to state A
    end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
