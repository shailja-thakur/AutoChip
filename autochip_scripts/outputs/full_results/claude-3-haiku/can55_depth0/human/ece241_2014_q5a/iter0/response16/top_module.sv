module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] state;
reg [7:0] next_state;
reg [7:0] sum;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 0;
        sum <= 0;
    end
    else begin
        state <= next_state;
        sum <= sum + x;
    end
end

always @(*) begin
    next_state = state + 1;
    z = 0;
    if (state == 255) begin
        z = ~sum + 1;
    end
end

endmodule
