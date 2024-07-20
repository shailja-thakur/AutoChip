module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @(a) begin
    case(a)
        3'h0: q = 16'd1232;
        3'h1: q = 16'daee0;
        3'h2: q = 16'd27d4;
        3'h3: q = 16'd5a0e;
        3'h4: q = 16'd2066;
        3'h5: q = 16'd64ce;
        3'h6: q = 16'dc526;
        3'h7: q = 16'd2f19;
        default: q = 16'd0;
    endcase
end

endmodule
