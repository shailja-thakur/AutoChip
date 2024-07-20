module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
    case (y)
        3'b000:
            if (x == 1) begin
                Y <= 3'b001;
                z <= 1'b0;
            end else begin
                Y <= 3'b000;
                z <= 1'b0;
            end
        3'b001:
            if (x == 1) begin
                Y <= 3'b100;
                z <= 1'b0;
            end else begin
                Y <= 3'b001;
                z <= 1'b0;
            end
        3'b010:
            if (x == 1) begin
                Y <= 3'b001;
                z <= 1'b0;
            end else begin
                Y <= 3'b010;
                z <= 1'b0;
            end
        3'b011:
            if (x == 1) begin
                Y <= 3'b010;
                z <= 1'b1;
            end else begin
                Y <= 3'b001;
                z <= 1'b0;
            end
        3'b100:
            if (x == 1) begin
                Y <= 3'b100;
                z <= 1'b1;
            end else begin
                Y <= 3'b011;
                z <= 1'b1;
            end
        default:
            Y <= 3'b000;
            z <= 1'b0;
    endcase
end

assign Y0 = Y[0];

endmodule
