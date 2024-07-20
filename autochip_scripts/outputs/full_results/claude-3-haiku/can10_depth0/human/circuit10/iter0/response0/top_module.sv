module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg current_state, next_state;

always @(posedge clk) begin
    current_state <= next_state;
    q <= current_state;
end

always @(*) begin
    case ({a, b})
        2'b00: next_state = current_state;
        2'b01: next_state = 1'b1;
        2'b10: next_state = 1'b0;
        2'b11: next_state = ~current_state;
    endcase

    case ({a, b})
        2'b00: state = current_state;
        2'b01: state = 1'b0;
        2'b10: state = 1'b1;
        2'b11: state = ~current_state;
    endcase
end

endmodule
