module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00;
    else
        state <= next_state;
end

always @* begin
    case (state)
        2'b00: begin
            next_state = x ? 2'b01 : 2'b00;
            z <= state[0] ? 1'b0 : 1'b0;
        end
        2'b01: begin
            next_state = x ? 2'b10 : 2'b01;
            z <= state[0] ? 1'b0 : 1'b1;
        end
        2'b10: begin
            next_state = x ? 2'b10 : 2'b10;
            z <= state[0] ? 1'b1 : 1'b1;
        end
    endcase
end

endmodule
