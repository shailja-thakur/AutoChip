module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @(*) begin
    case(a)
        3'd0: q = 16'h123A;
        3'd1: q = 16'hAFB0;
        3'd2: q = 16'h27D4;
        3'd3: q = 16'h59D6;
        3'd4: q = 16'h2056;
        3'd5: q = 16'h641E;
        3'd6: q = 16'hC57A;
        3'd7: q = 16'h2F19;
        default: q = 16'h0000; // Default value if a is out of range
    endcase
end

endmodule
