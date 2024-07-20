module top_module(
    input clk,
    input d,
    output reg q
);

reg q_pos, q_neg;

always @(posedge clk) begin
    q_pos <= d;
end

always @(negedge clk) begin
    q_neg <= d;
end

always @(posedge clk or negedge clk) begin
    case ({q_pos, q_neg})
        2'b01: q <= d;
        2'b10: q <= d;
        default: q <= q;
    endcase
end

endmodule
