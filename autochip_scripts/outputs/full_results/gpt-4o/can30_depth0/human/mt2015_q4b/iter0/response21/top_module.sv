module top_module(
    input x,
    input y,
    output reg z
);

always @(x or y)
begin
    case ({x, y})
        2'b00: z = 1;
        2'b01: z = 0;
        2'b10: z = 0;
        2'b11: z = 1;
        default: z = 1; // Default case to handle any unknown states
    endcase
end

endmodule
