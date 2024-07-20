module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
   
    always @* begin
        casex(in)
            8'b1xxxxxxx: pos = 0;
            8'b0xxxxxxx: pos = 0;
            
            8'b01xxxxxx: pos = 1;
            8'b00xxxxxx: pos = 0;
            
            8'b001xxxxx: pos = 2;
            8'b000xxxxx: pos = 0;
            
            8'b0001xxxx: pos = 3;
            8'b0000xxxx: pos = 0;
            
            8'b00001xxx: pos = 4;
            8'b00000xxx: pos = 0;
            
            8'b000001xx: pos = 5;
            8'b000000xx: pos = 0;
            
            8'b0000001x: pos = 6;
            8'b0000000x: pos = 0;
            
            8'b00000001: pos = 7;
            8'b00000000: pos = 0;
        endcase
    end

endmodule
