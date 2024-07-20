module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    // Next state logic
    always @(posedge clk) begin
        case ({y, x})
            3'b000, 1'b0: Y0 <= 1'b0;
            3'b001, 1'b0: Y0 <= 1'b0;
            3'b001, 1'b1: Y0 <= 1'b0;
            3'b010, 1'b0: Y0 <= 1'b0;
            3'b010, 1'b1: Y0 <= 1'b0;
            3'b011, 1'b0: Y0 <= 1'b1;
            3'b011, 1'b1: Y0 <= 1'b0;
            3'b100, 1'b0: Y0 <= 1'b1;
            3'b100, 1'b1: Y0 <= 1'b1;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        case ({y, x})
            3'b000, 1'b0: z <= 1'b0;
            3'b001, 1'b0: z <= 1'b0;
            3'b001, 1'b1: z <= 1'b0;
            3'b010, 1'b0: z <= 1'b0;
            3'b010, 1'b1: z <= 1'b0;
            3'b011, 1'b0: z <= 1'b1;
            3'b011, 1'b1: z <= 1'b0;
            3'b100, 1'b0: z <= 1'b1;
            3'b100, 1'b1: z <= 1'b1;
        endcase
    end

endmodule
