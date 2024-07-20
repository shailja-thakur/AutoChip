module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(*) begin
    case (state)
        2'b00: next_state = (in) ? 2'b01 : 2'b00;
        2'b01: next_state = (in) ? 2'b01 : 2'b10;
        2'b10: next_state = (in) ? 2'b11 : 2'b00;
        2'b11: next_state = (in) ? 2'b01 : 2'b10;
        default: next_state = 2'b00;
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00;
    end
    else begin
        state <= next_state;
    end
end

always @(posedge clk) begin
    out <= (state == 2'b11);
end

endmodule
