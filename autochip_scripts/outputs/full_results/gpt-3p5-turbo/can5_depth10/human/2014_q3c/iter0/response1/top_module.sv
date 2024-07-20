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
        3'b000_0:
            begin
                Y[2:0] <= 3'b000;
                Y0 <= 1'b0;
            end
        3'b001_0:
            begin
                Y[2:0] <= 3'b001;
                Y0 <= 1'b0;
            end
        3'b001_1:
            begin
                Y[2:0] <= 3'b100;
                Y0 <= 1'b0;
            end
        3'b010_0:
            begin
                Y[2:0] <= 3'b010;
                Y0 <= 1'b0;
            end
        3'b011_0:
            begin
                Y[2:0] <= 3'b001;
                Y0 <= 1'b0;
            end
        3'b011_1:
            begin
                Y[2:0] <= 3'b010;
                Y0 <= 1'b1;
            end
        3'b100_0:
            begin
                Y[2:0] <= 3'b011;
                Y0 <= 1'b1;
            end
        3'b100_1:
            begin
                Y[2:0] <= 3'b100;
                Y0 <= 1'b1;
            end
        default:
            begin
                Y[2:0] <= 3'b000;
                Y0 <= 1'b0;
            end
    endcase

    z <= Y0;
end

endmodule
