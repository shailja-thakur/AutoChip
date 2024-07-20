module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    case (in)
        4'b1000: pos = 2'd0;
        4'b1001: pos = 2'd0;
        4'b1010: pos = 2'd1;
        4'b1011: pos = 2'd1;
        4'b1100: pos = 2'd2;
        4'b1101: pos = 2'd2;
        4'b1110: pos = 2'd3;
        4'b1111: pos = 2'd3;
        default: pos = 2'd0;
    endcase
end

endmodule
