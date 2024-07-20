module top_module(
    input x,
    input y,
    output reg z
);

reg [1:0] state;

always @(x, y) begin
    case ({x, y})
        2'b00: begin
            state <= 2'b00;
            z <= 1'b1;
        end
        2'b01: begin
            state <= 2'b01;
            z <= 1'b0;
        end
        2'b10: begin
            state <= 2'b10;
            z <= 1'b0;
        end
        2'b11: begin
            state <= 2'b11;
            z <= 1'b1;
        end
    endcase
end

endmodule
