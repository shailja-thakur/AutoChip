module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

// State transition logic for Y0
always @(posedge clk) begin
    case (y)
        3'b000: Y0 <= x ? 1'b0 : 1'b0;
        3'b001: Y0 <= x ? 1'b0 : 1'b1;
        3'b010: Y0 <= x ? 1'b0 : 1'b0;
        3'b011: Y0 <= x ? 1'b0 : 1'b0;
        3'b100: Y0 <= x ? 1'b1 : 1'b1;
        default: Y0 <= 1'b0;
    endcase
end

// Combinational logic for z
always @(*) begin
    case (y)
        3'b011: z = 1'b1;
        3'b100: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
