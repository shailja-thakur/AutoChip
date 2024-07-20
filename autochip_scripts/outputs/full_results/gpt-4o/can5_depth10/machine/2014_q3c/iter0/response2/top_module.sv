module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    always_comb begin
        case ({y, x})
            4'b0000: Y0 = 0;
            4'b0001: Y0 = 1;
            4'b0010: Y0 = 1;
            4'b0011: Y0 = 0;
            4'b0100: Y0 = 0;
            4'b0101: Y0 = 1;
            4'b0110: Y0 = 1;
            4'b0111: Y0 = 0;
            4'b1000: Y0 = 1;
            4'b1001: Y0 = 0;
            default: Y0 = x;
        endcase
    end

    always_comb begin
        case (y)
            3'h0: z = 0;
            3'h1: z = 0;
            3'h2: z = 0;
            3'h3: z = 1;
            3'h4: z = 1;
            default: z = x;
        endcase
    end

endmodule
