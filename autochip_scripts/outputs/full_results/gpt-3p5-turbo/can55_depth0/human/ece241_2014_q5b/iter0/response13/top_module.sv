module top_module (
        input clk,
        input areset,
        input x,
        output z
);

reg [1:0] state;
wire next_state_a, next_state_b;

wire z_a;
assign z = (state == 2'b11) ? 1'b1 : 1'b0;

always @(posedge clk or posedge areset) begin
    if (areset == 1'b1)
        state <= 2'b00;
    else
        state <= next_state_a | next_state_b;
end

assign next_state_a = (state == 2'b00) & ~x;
assign next_state_b = (state == 2'b00) & x;

endmodule
