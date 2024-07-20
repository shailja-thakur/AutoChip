module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

    always @(*) begin
        casex (in)
            4'b0000: pos = 2'b00;
            4'bxxx1: pos = 2'b00; // highest priority
            4'bxx10: pos = 2'b01;
            4'bx100: pos = 2'b10;
            4'b1000: pos = 2'b11; // lowest priority
            default: pos = 2'b00;
        endcase
    end

endmodule
