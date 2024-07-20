module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
    case(y)
        3'b000: if (x == 0) Y <= 3'b000; else Y <= 3'b001;
        3'b001: if (x == 0) Y <= 3'b001; else Y <= 3'b100;
        3'b010: if (x == 0) Y <= 3'b010; else Y <= 3'b001;
        3'b011: if (x == 0) Y <= 3'b001; else Y <= 3'b010;
        3'b100: if (x == 0) Y <= 3'b011; else Y <= 3'b100;
        default: Y <= 3'b000;
    endcase
end

always @(posedge clk) begin
    case(y)
        3'b011, 3'b100: z <= 1;
        default: z <= 0;
    endcase
end

always @(posedge clk) begin
    Y0 <= Y[0];
end

endmodule
