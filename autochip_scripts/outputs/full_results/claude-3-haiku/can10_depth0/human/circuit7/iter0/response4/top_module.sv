module top_module (
    input clk,
    input a,
    output reg q
);

reg q_next;

always @(posedge clk) begin
    q <= q_next;
end

always @(*) begin
    case ({q, a})
        2'b00: q_next = 1'b1;
        2'b01: q_next = 1'b1;
        2'b10: q_next = 1'b0;
        2'b11: q_next = 1'b0;
    endcase
end

endmodule
