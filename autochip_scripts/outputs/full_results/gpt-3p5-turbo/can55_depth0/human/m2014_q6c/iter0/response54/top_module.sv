module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

reg Y2;
reg Y4;

always @(*)
begin
    case(y)
        7'b000001: begin
            Y2 = 0;
            Y4 = 0;
        end
        7'b000010: begin
            Y2 = 1;
            Y4 = 0;
        end
        7'b000100: begin
            Y2 = 0;
            Y4 = 1;
        end
        7'b001000: begin
            Y2 = w;
            Y4 = 0;
        end
        7'b010000: begin
            Y2 = 0;
            Y4 = w;
        end
        7'b100000: begin
            Y2 = 1;
            Y4 = 1;
        end
        default: begin
            Y2 = 0;
            Y4 = 0;
        end
    endcase
end

endmodule
