module top_module(
    input x,
    input y,
    output reg z
);

reg [1:0] state;
parameter [1:0] ZERO = 2'b00, ONE = 2'b01, TWO = 2'b10;

always @(x, y) begin
    case ({x, y})
        2'b00: state <= ZERO;
        2'b01: state <= ONE;
        2'b10: state <= TWO;
        2'b11: state <= ZERO;
    endcase
end

always @(state) begin
    case (state)
        ZERO: z <= 1'b1;
        ONE: z <= 1'b0;
        TWO: z <= 1'b0;
    endcase
end

endmodule
