module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

always @(posedge clk) begin
    case (y)
        3'b000: begin
            z <= 1'b0;
            if (x == 1'b0)
                Y0 <= 1'b0;
            else
                Y0 <= 1'b1;
        end
        3'b001: begin
            z <= 1'b0;
            if (x == 1'b0)
                Y0 <= 1'b1;
            else
                Y0 <= 3'b100[0];
        end
        3'b010: begin
            z <= 1'b0;
            if (x == 1'b0)
                Y0 <= 3'b010[0];
            else
                Y0 <= 3'b001[0];
        end
        3'b011: begin
            z <= 1'b1;
            if (x == 1'b0)
                Y0 <= 3'b001[0];
            else
                Y0 <= 3'b010[0];
        end
        3'b100: begin
            z <= 1'b1;
            if (x == 1'b0)
                Y0 <= 3'b011[0];
            else
                Y0 <= 3'b100[0];
        end
        default: begin
            z <= 1'b0;
            Y0 <= 1'b0;
        end
    endcase
end

endmodule
