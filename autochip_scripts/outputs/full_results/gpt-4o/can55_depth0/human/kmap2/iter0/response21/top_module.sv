module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    wire [3:0] ab = {a, b}; // Combine a and b into a 2-bit number
    wire [3:0] cd = {c, d}; // Combine c and d into a 2-bit number
    reg result;

    always @(*) begin
        case ({c, d, a, b})
            6'b000_00: result = 1;
            6'b000_01: result = 1;
            6'b000_10: result = 1;
            6'b000_11: result = 0;
            6'b001_00: result = 1;
            6'b001_01: result = 0;
            6'b001_10: result = 1;
            6'b001_11: result = 0;
            6'b010_00: result = 1;
            6'b010_01: result = 1;
            6'b010_10: result = 0;
            6'b010_11: result = 0;
            6'b011_00: result = 0;
            6'b011_01: result = 0;
            6'b011_10: result = 1;
            6'b011_11: result = 1;
            6'b100_00: result = 0;
            6'b100_01: result = 1;
            6'b100_10: result = 1;
            6'b100_11: result = 1;
            6'b101_00: result = 1;
            6'b101_01: result = 1;
            6'b101_10: result = 0;
            6'b101_11: result = 1;
            6'b110_00: result = 1;
            6'b110_01: result = 1;
            6'b110_10: result = 0;
            6'b110_11: result = 0;
            6'b111_00: result = 0;
            6'b111_01: result = 1;
            6'b111_10: result = 1;
            6'b111_11: result = 0;
            default: result = 0;
        endcase
    end

    assign out = result;

endmodule
