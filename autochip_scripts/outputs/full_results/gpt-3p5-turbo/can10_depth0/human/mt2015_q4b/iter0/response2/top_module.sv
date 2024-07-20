module top_module(
    input x,
    input y,
    output z);

    reg z;

    always @(x, y)
    begin
        case({x, y})
            2'b01: z = 0;
            2'b11: z = 1;
            default: z = 0;
        endcase
    end

endmodule
