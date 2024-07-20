module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg [2:0] Y,
    output reg z
);

always @(posedge clk) begin
    case (y)
        3'b000: Y = (x == 0) ? 3'b000 : 3'b001;
        3'b001: Y = (x == 0) ? 3'b001 : 3'b100;
        3'b010: Y = (x == 0) ? 3'b010 : 3'b001;
        3'b011: Y = (x == 0) ? 3'b001 : 3'b010;
        3'b100: Y = (x == 0) ? 3'b011 : 3'b100;
        default: Y = 3'b000;
    endcase
end

always @(y) begin
    case (y)
        3'b011: z = 1;
        3'b100: z = 1;
        default: z = 0;
    endcase
end

assign Y0 = Y[0];

endmodule
