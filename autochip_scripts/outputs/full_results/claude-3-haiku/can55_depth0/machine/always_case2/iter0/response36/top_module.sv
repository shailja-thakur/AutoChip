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
        4'hA: pos = 2'b01;
        4'hB: pos = 2'b00;
        4'hC: pos = 2'b10;
        4'hD: pos = 2'b00;
        4'hE: pos = 2'b01;
        4'hF: pos = 2'b00;
        default: pos = 2'b00;
    endcase
end

endmodule
