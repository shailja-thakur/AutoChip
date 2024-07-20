module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(y or w)
    begin
        case (y)
            3'b000:
                if (w)
                    Y2 <= 1'b0; // transition: A (0) --1--> A
                else
                    Y2 <= 1'b1; // transition: A (0) --0--> B
            3'b001:
                if (w)
                    Y2 <= 1'b0; // transition: B (0) --1--> D
                else
                    Y2 <= 1'b0; // transition: B (0) --0--> C
            3'b010:
                Y2 <= 1'b0;     // transition: C (0) --0--> E
            3'b011:
                Y2 <= 1'b0;     // transition: C (0) --1--> D
            3'b100:
                Y2 <= 1'b0;     // transition: D (0) --0--> F
            3'b101:
                Y2 <= 1'b1;     // transition: D (0) --1--> A
            3'b110:
                if (w)
                    Y2 <= 1'b0; // transition: E (1) --1--> D
                else
                    Y2 <= 1'b1; // transition: E (1) --0--> E
            3'b111:
                if (w)
                    Y2 <= 1'b0; // transition: F (1) --1--> D
                else
                    Y2 <= 1'b0; // transition: F (1) --0--> C
        endcase
    end

endmodule
