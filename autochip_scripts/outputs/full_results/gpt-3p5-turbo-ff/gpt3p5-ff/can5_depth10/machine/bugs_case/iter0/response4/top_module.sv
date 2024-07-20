module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

    always @(*)
    begin
        valid = 1;
        
        case(code)
            8'h45: out = 4'b0;
            8'h16: out = 4'b1;
            8'h1e: out = 4'b2;
            8'h26: out = 4'b3;
            8'h25: out = 4'b4;
            8'h2e: out = 4'b5;
            8'h36: out = 4'b6;
            8'h3d: out = 4'b7;
            8'h3e: out = 4'b8;
            8'h46: out = 4'b9;
            default: valid = 0;
        endcase
    end
    
endmodule
