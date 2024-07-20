module top_module (
    input [7:0] in,
    output reg [2:0] pos
);


always @* begin
    case(in)
        8'bzzzzzzz1: pos = 3'b000; // Case 1
        8'b1zzzzzzz: pos = 3'b001; // Case 2    
        8'bzzzz1zzz: pos = 3'b010; // Case 3
        8'bzz1zzzzz: pos = 3'b011; // Case 4
        8'bz1zzzzzz: pos = 3'b100; // Case 5
        8'bzzzzzz1z: pos = 3'b101; // Case 6
        8'b1zzzzz1z: pos = 3'b110; // Case 7
        8'bzzz1zzzz: pos = 3'b111; // Case 8

        default: pos = 3'b000;
    endcase
end

endmodule
