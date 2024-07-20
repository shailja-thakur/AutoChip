module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00; // state A
    else if (state == 2'b00) begin // state A
        if (j)
            state <= 2'b01; // transition to state B
        else
            state <= 2'b00; // remain in state A
    end else if (state == 2'b01) begin // state B
        if (k)
            state <= 2'b00; // transition to state A
        else
            state <= 2'b01; // remain in state B
    end
end

always @(posedge clk)
    out <= (state == 2'b01) ? 1'b1 : 1'b0; // output high when state is B, low when state is A

endmodule
