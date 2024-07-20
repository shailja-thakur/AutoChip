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
    case ({a, b, current_state})
        3'b100: next_state = 1'b0;
        3'b000: next_state = 1'b0;
        3'b001: next_state = 1'b1;
        3'b011: next_state = 1'b0;
        3'b111: next_state = 1'b1;
        3'b110: next_state = 1'b0;
        default: next_state = current_state;
    endcase

    state = current_state;
end

endmodule
