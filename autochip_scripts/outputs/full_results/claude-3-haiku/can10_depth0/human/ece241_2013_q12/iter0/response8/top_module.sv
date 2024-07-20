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

    // Combinational logic for output Z
    always @(*) begin
        case ({A, B, C})
            3'b000: Z = shift_reg[0];
            3'b001: Z = shift_reg[1];
            3'b010: Z = shift_reg[2];
            3'b011: Z = shift_reg[3];
            3'b100: Z = shift_reg[4];
            3'b101: Z = shift_reg[5];
            3'b110: Z = shift_reg[6];
            3'b111: Z = shift_reg[7];
            default: Z = 1'b0;
        endcase
    end

endmodule
