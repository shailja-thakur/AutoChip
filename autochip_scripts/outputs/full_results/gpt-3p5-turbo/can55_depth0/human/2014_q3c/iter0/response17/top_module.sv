module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
	always @(posedge clk) begin
		case ({y, x})
            3'b000, 1'b0: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
            3'b000, 1'b1: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
            3'b001, 1'b0: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
            3'b001, 1'b1: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
            3'b010, 1'b0: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
            3'b010, 1'b1: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
            3'b011, 1'b0: begin
                Y0 <= 1'b0;
                z <= 1'b1;
            end
            3'b011, 1'b1: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
            3'b100, 1'b0: begin
                Y0 <= 1'b1;
                z <= 1'b1;
            end
            3'b100, 1'b1: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
            default: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
		endcase
	end
endmodule
