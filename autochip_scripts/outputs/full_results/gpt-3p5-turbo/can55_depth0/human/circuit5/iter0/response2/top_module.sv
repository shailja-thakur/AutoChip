module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);
    
    always @* begin
        case ({a, b, c, d, e})
            4'b?????: q = 4'b????; // Replace ??? with the correct values
            4'b010de: q = 4'b1001;
            4'b010dd: q = 4'b1101;
            default: q = 4'b1111;
        endcase
    end

endmodule
