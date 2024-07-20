module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);
    reg [1:0] ab;
    reg [1:0] cd;

    always @(*) begin
        ab = {a, b};
        cd = {c, d};

        case (ab)
            2'b00: begin
                case (cd)
                    2'b00: out = 1'b0;
                    2'b01: out = 1'b1;
                    2'b10: out = 1'b0;
                    2'b11: out = 1'b1;
                endcase
            end

            2'b01: begin
                case (cd)
                    2'b00: out = 1'b1;
                    2'b01: out = 1'b0;
                    2'b10: out = 1'b1;
                    2'b11: out = 1'b0;
                endcase
            end

            2'b10: begin
                case (cd)
                    2'b00: out = 1'b0;
                    2'b01: out = 1'b1;
                    2'b10: out = 1'b0;
                    2'b11: out = 1'b1;
                endcase
            end

            2'b11: begin
                case (cd)
                    2'b00: out = 1'b1;
                    2'b01: out = 1'b0;
                    2'b10: out = 1'b1;
                    2'b11: out = 1'b0;
                endcase
            end
        endcase
    end

endmodule
