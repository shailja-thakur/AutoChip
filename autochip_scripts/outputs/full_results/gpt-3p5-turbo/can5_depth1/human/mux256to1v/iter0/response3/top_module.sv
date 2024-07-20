module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [255:0] temp; // Intermediate register to store the selected 4-bit input

always @(*) begin
    case(sel)
        8'b00000000: temp = in[3:0];
        8'b00000001: temp = in[7:4];
        8'b00000010: temp = in[11:8];
        // Add more cases for all 256 possible selections
        // ...
        // ...
        8'b11111111: temp = in[1023:1020];
    endcase
    
    out = temp[3:0];
end

endmodule
