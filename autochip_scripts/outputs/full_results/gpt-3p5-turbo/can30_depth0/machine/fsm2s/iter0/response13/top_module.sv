module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00; // State A
    else
        state <= next_state;
end

always @* begin
    if (state == 2'b00) begin
        if (j)
            next_state = 2'b01; // State B
        else
            next_state = 2'b00; // State A
    end else if (state == 2'b01) begin
        if (k)
            next_state = 2'b00; // State A
        else
            next_state = 2'b01; // State B
    end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
