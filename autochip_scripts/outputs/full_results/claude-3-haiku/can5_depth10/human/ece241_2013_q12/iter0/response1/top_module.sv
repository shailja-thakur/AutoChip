module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

    // 8-bit shift register
    reg [7:0] shift_reg;

    always @(posedge clk) begin
        if (enable) begin
            shift_reg <= {shift_reg[6:0], S};
        end
    end

    // 3-to-8 decoder
    wire [7:0] decoder_out;
    assign decoder_out[0] = ~A & ~B & ~C;
    assign decoder_out[1] = ~A & ~B &  C;
    assign decoder_out[2] = ~A &  B & ~C;
    assign decoder_out[3] = ~A &  B &  C;
    assign decoder_out[4] =  A & ~B & ~C;
    assign decoder_out[5] =  A & ~B &  C;
    assign decoder_out[6] =  A &  B & ~C;
    assign decoder_out[7] =  A &  B &  C;

    // 8-to-1 multiplexer
    always @(*) begin
        case (decoder_out)
            8'b00000001: Z = shift_reg[0];
            8'b00000010: Z = shift_reg[1];
            8'b00000100: Z = shift_reg[2];
            8'b00001000: Z = shift_reg[3];
            8'b00010000: Z = shift_reg[4];
            8'b00100000: Z = shift_reg[5];
            8'b01000000: Z = shift_reg[6];
            8'b10000000: Z = shift_reg[7];
            default: Z = 1'b0;
        endcase
    end

endmodule
