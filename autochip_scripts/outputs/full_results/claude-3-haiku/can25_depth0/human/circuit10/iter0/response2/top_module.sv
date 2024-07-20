module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg current_state;

always @(posedge clk) begin
    case ({a, b})
        2'b00: current_state <= current_state;
        2'b01: current_state <= 1'b0;
        2'b10: current_state <= 1'b0;
        2'b11: current_state <= ~current_state;
    endcase
    q <= current_state;
    state <= current_state;
end

endmodule
