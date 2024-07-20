module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b 00?? : f = 0;
        4'b 01?0 : f = 0;
        4'b 01?1 : f = 1;
        4'b 1??? : f = 1;
        default  : f = 0;
    endcase
end

endmodule
