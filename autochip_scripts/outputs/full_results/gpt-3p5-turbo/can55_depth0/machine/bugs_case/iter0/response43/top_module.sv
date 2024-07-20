module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

    always @(*) begin
        case (code)
            8'h45: out = 4'b0000;  // A
            8'h16: out = 4'b0001;  // B
            8'h1e: out = 4'b0010;  // C
            8'h26: out = 4'b0011;  // D
            8'h25: out = 4'b0100;  // E
            8'h2e: out = 4'b0101;  // F
            8'h36: out = 4'b0110;  // G
            8'h3d: out = 4'b0111;  // H
            8'h3e: out = 4'b1000;  // I
            8'h46: out = 4'b1001;  // J
            default: out = 4'b0000; // Invalid key
        endcase
        
        valid = (out == 4'b0000) ? 1'b0 : 1'b1;
    end

endmodule
