module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);
    reg [2:0] Y; // Internal state

    always @(posedge clk) begin
        case (y)
            3'b000: Y <= x ? 3'b001 : 3'b000;
            3'b001: Y <= x ? 3'b100 : 3'b001;
            3'b010: Y <= x ? 3'b001 : 3'b010;
            3'b011: Y <= x ? 3'b010 : 3'b001;
            3'b100: Y <= x ? 3'b100 : 3'b011;
            default: Y <= 3'b000; // Default case to handle unknown states
        endcase
    end

    always @(posedge clk) begin
        Y0 <= Y[0];
    end

    always @(*) begin
        case (y)
            3'b011, 3'b100: z = 1;
            default: z = 0;
        endcase
    end
endmodule
