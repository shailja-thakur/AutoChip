module top_module (
    input clk,
    input wire x,
    input wire [2:0] y,
    output reg Y0,
    output reg z
);

always @(posedge clk) begin
    case({y, x})
        3'b000_0, 3'b001_0, 3'b010_0, 3'b100_0: begin
            Y0 <= 1'b0;
            z <= 1'b0;
        end
        3'b001_1, 3'b011_1, 3'b100_1: begin
            Y0 <= 1'b0;
            z <= 1'b1;
        end
        3'b000_1: begin
            Y0 <= 1'b0;
            z <= 1'b0;
        end
        3'b010_1: begin
            Y0 <= 1'b1;
            z <= 1'b0;
        end
        3'b011_0: begin
            Y0 <= 1'b1;
            z <= 1'b0;
        end
        default: begin
            Y0 <= 1'b0;
            z <= 1'b0;
        end
    endcase
end

endmodule
