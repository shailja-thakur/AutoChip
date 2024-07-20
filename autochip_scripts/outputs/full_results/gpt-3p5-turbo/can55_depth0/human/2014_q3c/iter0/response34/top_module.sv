module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
    case({x, y})
        2'b00_0: Y <= 3'b00_0;
        2'b01_0: Y <= 3'b01_0;
        2'b01_1: Y <= 3'b10_0;
        2'b10_0: Y <= 3'b11_0;
        2'b11_0: Y <= 3'b00_1;
    endcase
end

assign Y0 = Y[0];
assign z = (Y[2] ^ Y[0]);

endmodule
