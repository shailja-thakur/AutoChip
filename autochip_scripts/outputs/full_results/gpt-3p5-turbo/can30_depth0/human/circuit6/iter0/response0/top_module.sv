module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @(a) begin
    case(a)
        0: q <= 16'd1232;
        1: q <= 16'daee0;
        2: q <= 16'd27d4;
        3: q <= 16'd5a0e;
        4: q <= 16'd2066;
        5: q <= 16'd64ce;
        6: q <= 16'dc526;
        7: q <= 16'd2f19;
        default: q <= 16'd0;
    endcase
end

endmodule
