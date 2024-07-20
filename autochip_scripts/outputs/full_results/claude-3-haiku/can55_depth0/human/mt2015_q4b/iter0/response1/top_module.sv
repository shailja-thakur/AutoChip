module top_module(
    input x,
    input y,
    output reg z
);

reg [1:0] state;

always @(*) begin
    case (state)
        2'b00: z = 1'b1;
        2'b01: z = 1'b0;
        2'b10: z = 1'b0;
        2'b11: z = 1'b1;
        default: z = 1'b0;
    endcase
end

always @(x, y) begin
    case ({x, y})
        2'b00: state <= 2'b00;
        2'b01: state <= 2'b10;
        2'b10: state <= 2'b01;
        2'b11: state <= 2'b11;
        default: state <= 2'b00;
    endcase
end

endmodule
