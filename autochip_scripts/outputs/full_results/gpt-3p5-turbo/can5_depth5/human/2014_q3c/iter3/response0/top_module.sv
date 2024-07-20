module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg [2:0] Y,
    output reg Y0,
    output reg z
);

always @(posedge clk) begin
    case ({y, x})
        3'b000: begin
            Y <= 3'b000;
            z <= 1'b0;
        end
        3'b001: begin
            Y <= x ? 3'b100 : 3'b001;
            z <= 1'b0;
        end
        3'b010: begin
            Y <= 3'b001;
            z <= 1'b0;
        end
        3'b011: begin
            Y <= x ? 3'b010 : 3'b001;
            z <= 1'b1;
        end
        3'b100: begin
            Y <= x ? 3'b011 : 3'b100;
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
