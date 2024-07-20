module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg [7:0] q,
    output reg Z
);
        
    reg [7:0] shift_reg;
    reg [2:0] address;

    always @(posedge clk)
    begin
        if (enable)
        begin
            shift_reg <= {S, shift_reg[7:1]};
        end
        else
        begin
            shift_reg <= shift_reg;
        end
    end

    always @(A or B or C)
    begin
        address <= {A, B, C};
    end

    always @(address)
    begin
        case (address)
            3'b000: Z <= shift_reg[0];
            3'b001: Z <= shift_reg[1];
            3'b010: Z <= shift_reg[2];
            3'b011: Z <= shift_reg[3];
            3'b100: Z <= shift_reg[4];
            3'b101: Z <= shift_reg[5];
            3'b110: Z <= shift_reg[6];
            3'b111: Z <= shift_reg[7];
            default: Z <= 1'b0;
        endcase
    end

endmodule
