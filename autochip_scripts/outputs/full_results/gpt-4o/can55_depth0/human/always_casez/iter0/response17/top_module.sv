module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    always @(*) begin
        casez (in)
            8'bzzzzzzz1: pos = 3'd0;
            8'bzzzzzz10: pos = 3'd1;
            8'bzzzzz100: pos = 3'd2;
            8'bzzzz1000: pos = 3'd3;
            8'bzzz10000: pos = 3'd4;
            8'bzz100000: pos = 3'd5;
            8'bz1000000: pos = 3'd6;
            8'b10000000: pos = 3'd7;
            default: pos = 3'd0; // If no bits are high, output 0
        endcase
    end
endmodule
