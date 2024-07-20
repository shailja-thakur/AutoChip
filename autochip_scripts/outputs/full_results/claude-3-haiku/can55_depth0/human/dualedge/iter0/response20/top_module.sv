module top_module(
    input clk,
    input d,
    output reg q
);

reg d_ff1, d_ff2;

always @(posedge clk) begin
    d_ff1 <= d;
end

always @(negedge clk) begin
    d_ff2 <= d;
end

always @(posedge clk or negedge clk) begin
    case ({d_ff1, d_ff2})
        2'b00: q <= q;
        2'b01: q <= 1'b0;
        2'b10: q <= 1'b1;
        2'b11: q <= d;
    endcase
end

endmodule
