module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg Y1;
reg Y3;

always @(y or w) begin
    case (y)
        6'b000001: begin
            Y1 <= y[0];
            Y3 <= y[2];
        end
        6'b000010: begin
            Y1 <= y[0];
            Y3 <= y[2];
        end
        6'b000100: begin
            Y1 <= y[0];
            Y3 <= y[2];
        end
        6'b001000: begin
            Y1 <= y[0];
            Y3 <= y[2];
        end
        6'b010000: begin
            Y1 <= y[0];
            Y3 <= y[2];
        end
        6'b100000: begin
            Y1 <= y[0];
            Y3 <= y[2];
        end
        default: begin
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
    endcase
end
endmodule
