module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);

    wire sop0, sop1;
    wire pos0, pos1;

    // Sum-of-Products (SOP) logic
    assign sop0 = c & d;
    assign sop1 = (~a) & (~b) & c;
    assign out_sop = sop0 | sop1;

    // Product-of-Sums (POS) logic
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~b) | ((~a) | d));

    always @* begin
        if (pos0 == pos1)
            out_pos = pos0;
        else
            out_pos = 1'bx; // x means unknown
    end

endmodule
