module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

always @(*)
begin
    case (y)
        3'b000: begin
            if (x == 1'b0)
                Y0 = 1'b0;
            else
                Y0 = 1'b1;
            z = 1'b0;
        end
        3'b001: begin
            if (x == 1'b0)
                Y0 = 1'b1;
            else
                Y0 = 1'b0;
            z = 1'b0;
        end
        3'b010: begin
            if (x == 1'b0)
                Y0 = 1'b0;
            else
                Y0 = 1'b1;
            z = 1'b0;
        end
        3'b011: begin
            if (x == 1'b0)
                Y0 = 1'b1;
            else
                Y0 = 1'b0;
            z = 1'b1;
        end
        3'b100: begin
            if (x == 1'b0)
                Y0 = 1'b1;
            else
                Y0 = 1'b0;
            z = 1'b1;
        end
        default: begin
            Y0 = 1'b0;
            z = 1'b0;
        end
    endcase
end

endmodule
