module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

    always @* begin
        out = 4'b0;
        valid = 1'b1;

        case (code)
            8'h45: out = 4'b0;
            8'h16: out = 4'b1;
            8'h1e: out = 4'b10;
            8'h26: out = 4'b11;
            8'h25: out = 4'b100;
            8'h2e: out = 4'b101;
            8'h36: out = 4'b110;
            8'h3d: out = 4'b111;
            8'h3e: out = 4'b1000;
            8'h46: out = 4'b1001;
            default: valid = 1'b0;
        endcase
    end
endmodule
