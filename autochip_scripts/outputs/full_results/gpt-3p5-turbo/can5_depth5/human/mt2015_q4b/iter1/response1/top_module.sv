module top_module(
    input x,
    input y,
    output z
);

    reg z;
    always @*
        case({x, y})
            2'b00: z = 1'b1;
            default: z = 1'b0;
        endcase
    
endmodule
