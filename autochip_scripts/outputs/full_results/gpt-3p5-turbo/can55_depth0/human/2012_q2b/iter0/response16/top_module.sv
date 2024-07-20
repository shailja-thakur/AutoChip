module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg Y1;
reg Y3;

// Y1 Output Logic
always @(y[1])
begin
    case(y[1])
        1'b0: Y1 = w;
        1'b1: Y1 = w;
        default: Y1 = 1'b0;
    endcase
end

// Y3 Output Logic
always @(y[3])
begin
    case(y[3])
        1'b0: Y3 = w;
        1'b1: Y3 = !w;
        default: Y3 = 1'b0;
    endcase
end

endmodule
