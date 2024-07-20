module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    case ({q[2], q[1], q[0], a})
        4'b0000: q <= 4;
        4'b0001: q <= 4;
        4'b0101: q <= 5;
        4'b0110: q <= 6;
        default: q <= 0;
    endcase
end

endmodule
