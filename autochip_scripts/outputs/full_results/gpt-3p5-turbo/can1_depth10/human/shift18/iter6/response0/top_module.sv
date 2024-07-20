module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

    reg [63:0] shift_reg;

    always @(posedge clk) begin
        if (load) begin
            shift_reg <= data;
        end else if (ena) begin
            case(amount)
                2'b00: shift_reg <= shift_reg << 1;
                2'b01: shift_reg <= shift_reg << 8;
                2'b10: shift_reg <= $signed(shift_reg) >>> 1;
                2'b11: shift_reg <= $signed(shift_reg) >>> 8;
            endcase
        end
    end

    assign q = shift_reg;

endmodule
