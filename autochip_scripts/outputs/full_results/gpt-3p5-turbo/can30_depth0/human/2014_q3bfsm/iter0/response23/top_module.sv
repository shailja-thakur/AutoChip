module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] y, next_y;

always@(posedge clk or posedge reset) begin
    if (reset) begin
        y <= 3'b000;
        z <= 1'b0;
    end else begin
        y <= next_y;
        z <= (y == 3'b011) ? 1'b1 : 1'b0;
    end
end

always@(y or x) begin
    case (y)
        3'b000: next_y = (x == 1'b0) ? 3'b000 : 3'b001;
        3'b001: next_y = (x == 1'b0) ? 3'b001 : 3'b100;
        3'b010: next_y = (x == 1'b0) ? 3'b010 : 3'b001;
        3'b011: next_y = (x == 1'b0) ? 3'b001 : 3'b010;
        3'b100: next_y = (x == 1'b0) ? 3'b011 : 3'b100;
        default: next_y = 3'b000;
    endcase
end

endmodule
