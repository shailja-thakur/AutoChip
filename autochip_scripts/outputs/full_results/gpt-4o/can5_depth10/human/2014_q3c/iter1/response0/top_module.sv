module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

reg [2:0] y_next;

always @* begin
    case (y)
        3'b000: begin
            y_next = x ? 3'b001 : 3'b000;
            z = 0;
        end
        3'b001: begin
            y_next = x ? 3'b100 : 3'b001;
            z = 0;
        end
        3'b010: begin
            y_next = x ? 3'b001 : 3'b010;
            z = 0;
        end
        3'b011: begin
            y_next = x ? 3'b010 : 3'b001;
            z = 1;
        end
        3'b100: begin
            y_next = x ? 3'b100 : 3'b011;
            z = 1;
        end
        default: begin
            y_next = 3'b000;
            z = 0;
        end
    endcase
    Y0 = y_next[0];
end

endmodule
