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
            3'b000: Y <= (x) ? 3'b001 : 3'b000;
            3'b001: Y <= (x) ? 3'b100 : 3'b001;
            3'b010: Y <= 3'b001;
            3'b011: Y <= (x) ? 3'b010 : 3'b001;
            3'b100: Y <= (x) ? 3'b100 : 3'b011;
            default: Y <= 3'b000;
        endcase
    end

    always @(posedge clk) begin
        case (Y)
            3'b000: Y0 <= 1'b0;
            default: Y0 <= 1'b1;
        endcase
    end

    always @(posedge clk) begin
        case ({y, x})
            4'b0110: z <= 1'b1;
            default: z <= 1'b0;
        endcase
    end

endmodule
