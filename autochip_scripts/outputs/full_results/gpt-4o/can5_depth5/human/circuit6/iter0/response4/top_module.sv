module top_module (
    input [2:0] a,
    output reg [15:0] q
);

    // Combinational logic to determine q based on input a
    always @(*) begin
        case (a)
            3'b000: q = 16'h1232; // 0
            3'b001: q = 16'haee0; // 1
            3'b010: q = 16'h27d4; // 2
            3'b011: q = 16'h5a0e; // 3
            3'b100: q = 16'h2066; // 4
            3'b101: q = 16'h64ce; // 5
            3'b110: q = 16'hc526; // 6
            3'b111: q = 16'h2f19; // 7
            default: q = 16'h0000;
        endcase
    end

endmodule
