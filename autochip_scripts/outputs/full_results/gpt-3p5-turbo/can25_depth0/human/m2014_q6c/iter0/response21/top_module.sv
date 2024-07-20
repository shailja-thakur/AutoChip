module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Next-state logic for Y2
    always @(*)
    begin
        case(y)
            6'b000001: Y2 = 1'b0;
            6'b000010: Y2 = 1'b1;
            6'b000100: Y2 = 1'b0;
            6'b001000: Y2 = 1'b0;
            6'b010000: Y2 = 1'b0;
            6'b100000: Y2 = 1'b1;
            default: Y2 = 1'b0;
        endcase
    end

    // Next-state logic for Y4
    always @(*)
    begin
        case(y)
            6'b000001: Y4 = 1'b0;
            6'b000010: Y4 = 1'b1;
            6'b000100: Y4 = 1'b0;
            6'b001000: Y4 = 1'b0;
            6'b010000: Y4 = 1'b0;
            6'b100000: Y4 = 1'b0;
            default: Y4 = 1'b0;
        endcase
    end

endmodule
