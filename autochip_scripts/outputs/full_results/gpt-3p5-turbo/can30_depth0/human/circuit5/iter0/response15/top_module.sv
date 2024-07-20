module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @(*)
begin
    case({a, b, c, d, e})
        // if a=0000, b=0000, c=0000, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b b;
        
        // if a=0000, b=0000, c=0001, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b e;

        // if a=0000, b=0000, c=0010, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b a;

        // if a=0000, b=0000, c=0011, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b d;

        // if a=0000, b=0000, c=0100, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=0101, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=0110, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=0111, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=1000, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=1001, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=1010, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=1011, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=1100, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=1101, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=1110, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;

        // if a=0000, b=0000, c=1111, d=0000, e=0000
        15'b xxxxxxxxxxxxx => q = 4'b f;
        
        default: q = 4'b x;
    endcase
end

endmodule
