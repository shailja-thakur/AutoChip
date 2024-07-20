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
            3'b0000, 3'b0001: Y <= 3'b000;
            3'b0010: Y <= 3'b001;
            3'b0100: Y <= 3'b010;
            3'b0110: Y <= 3'b001;
            3'b0111: Y <= 3'b010;
            3'b1000: Y <= 3'b011;
            default: Y <= 3'b000;
        endcase
    end

    always @(posedge clk) begin
        case ({y, x})
            3'b0011, 3'b1101: z <= 1'b1;
            3'b0101, 3'b1001: z <= 1'b0;
            default: z <= 1'b0;
        endcase
    end

    assign Y0 = Y[0];

endmodule
