module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
    case({y, x})
        4'b0000: begin
            Y <= 3'b000;
            z <= 1'b0;
        end
        4'b001X: begin
            Y <= 3'b001;
            z <= 1'b0;
        end
        4'b0100: begin
            Y <= 3'b010;
            z <= 1'b0;
        end
        4'b011X: begin
            Y <= 3'b001;
            z <= 1'b1;
        end
        4'b100X: begin
            Y <= 3'b011;
            z <= 1'b1;
        end
        default: begin
            Y <= 3'b000;
            z <= 1'b0;
        end
    endcase
end

assign Y0 = Y[0];

endmodule
