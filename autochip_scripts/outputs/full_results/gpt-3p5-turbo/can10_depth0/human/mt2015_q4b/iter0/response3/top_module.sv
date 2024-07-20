module top_module(
    input x,
    input y,
    output z);

    reg z;

    always @(x or y)
    begin
        case ({x, y})
            2'b00: z = 1'b1;
            2'b01: z = 1'b0;
            2'b10: z = 1'b0;
            default: z = 1'b1;
        endcase
    end

endmodule
