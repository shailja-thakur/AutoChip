module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    case (in)
        4'h0: pos = 2'b00;
        4'h1: pos = 2'b00;
        4'h2: pos = 2'b01;
        4'h3: pos = 2'b00;
        4'h4: pos = 2'b10;
        4'h5: pos = 2'b00;
        4'h6: pos = 2'b01;
        4'h7: pos = 2'b00;
        4'h8: pos = 2'b11;
        4'h9: pos = 2'b00;
        4'ha: pos = 2'b01;
        4'hb: pos = 2'b00;
        4'hc: pos = 2'b10;
        4'hd: pos = 2'b00;
        4'he: pos = 2'b01;
        4'hf: pos = 2'b00;
        default: pos = 2'b00;
    endcase
end

endmodule
