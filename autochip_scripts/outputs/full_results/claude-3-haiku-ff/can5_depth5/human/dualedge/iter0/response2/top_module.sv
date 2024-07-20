module top_module(
    input clk,
    input d,
    output reg q
);

reg q_posedge, q_negedge;

always @(posedge clk) begin
    q_posedge <= d;
end

always @(negedge clk) begin
    q_negedge <= d;
end

always @(posedge clk or negedge clk) begin
    case ({q_posedge, q_negedge})
        2'b00: q <= 1'b0;
        2'b01: q <= 1'b0;
        2'b10: q <= 1'b1;
        2'b11: q <= q;
    endcase
end

endmodule
