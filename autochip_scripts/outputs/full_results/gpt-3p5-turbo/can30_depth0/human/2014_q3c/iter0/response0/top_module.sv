module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] Y;
always @(posedge clk) begin
    case ({y, x})
        3'b000_0: Y <= 3'b000;  // Next state when x=0
        3'b000_1: Y <= 3'b001;  // Next state when x=1
        3'b001_0: Y <= 3'b001;  // Next state when x=0
        3'b001_1: Y <= 3'b100;  // Next state when x=1
        3'b010_0: Y <= 3'b010;  // Next state when x=0
        3'b010_1: Y <= 3'b001;  // Next state when x=1
        3'b011_0: Y <= 3'b001;  // Next state when x=0
        3'b011_1: Y <= 3'b010;  // Next state when x=1
        3'b100_0: Y <= 3'b011;  // Next state when x=0
        3'b100_1: Y <= 3'b100;  // Next state when x=1
        default: Y <= 3'b000;  // Default next state
    endcase
end

assign Y0 = Y[0];
assign z = (Y == 3'b011) || (Y == 3'b100);

endmodule
