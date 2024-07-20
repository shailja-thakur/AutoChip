module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
    case ({x, y})
        2'b00: Y <= 3'b000;
        2'b01: Y <= x ? 3'b100 : 3'b001;
        2'b10: Y <= 3'b001;
        2'b11: Y <= x ? 3'b010 : 3'b001;
    endcase
end

assign Y0 = Y[0];
assign z = Y[1] | Y[2];

endmodule
