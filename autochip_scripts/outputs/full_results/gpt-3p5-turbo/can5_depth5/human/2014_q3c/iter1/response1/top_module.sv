module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

reg [2:0] Y_reg;

always @(posedge clk) begin
    case ({y, x})
        3'b000: begin
            Y_reg <= 3'b000;
            z <= 1'b0;
        end
        3'b001: begin
            Y_reg <= x ? 3'b100 : 3'b001;
            z <= 1'b0;
        end
        3'b010: begin
            Y_reg <= 3'b001;
            z <= 1'b0;
        end
        3'b011: begin
            Y_reg <= 3'b010;
            z <= 1'b1;
        end
        3'b100: begin
            Y_reg <= x ? 3'b100 : 3'b011;
            z <= 1'b1;
        end
        default: begin
            Y_reg <= 3'b000;
            z <= 1'b0;
        end
    endcase
end

assign Y0 = Y_reg[0];

endmodule
