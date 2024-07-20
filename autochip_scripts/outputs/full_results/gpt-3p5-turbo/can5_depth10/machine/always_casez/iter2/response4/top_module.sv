module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(in) begin
    case(in)
        8'b00?1????: pos <= 3'h0;
        8'b1?0?????: pos <= 3'h6;
        default: pos <= 3'h0;
    endcase
end

endmodule
