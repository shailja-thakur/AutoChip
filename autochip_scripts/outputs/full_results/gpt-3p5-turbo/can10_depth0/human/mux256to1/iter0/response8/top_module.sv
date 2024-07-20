module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);
 
// Create a 1-bit wide, 256-to-1 multiplexer
reg [0:255] temp;
always @(*) begin
    case (sel)
        8'b00000000: temp = in[0];
        8'b00000001: temp = in[1];
        8'b00000010: temp = in[2];
        // continue with the remaining 253 cases
        default: temp = in[0];
    endcase
end
 
assign out = temp;
 
endmodule
