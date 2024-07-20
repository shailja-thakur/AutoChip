module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    always @* begin
        casez(in)
            8'b0??: pos = 0;
            8'b?0?: pos = 1;
            8'b??:0 pos = 2;
            8'b???:0 pos = 3;
            8'b???: pos = 4;
            8'b???: pos = 5;
            8'b???: pos = 6;
            8'b???: pos = 7;
            default: pos = 0;
        endcase
    end

endmodule
