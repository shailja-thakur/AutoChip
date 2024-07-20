module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    case (in)
        4'b1000: pos = 2'd3;
        4'b0100: pos = 2'd2;
        4'b0010: pos = 2'd1;
        4'b0001: pos = 2'd0;
        default: pos = 2'd0; // If none of the input bits are high, output 0
    endcase
end

endmodule
