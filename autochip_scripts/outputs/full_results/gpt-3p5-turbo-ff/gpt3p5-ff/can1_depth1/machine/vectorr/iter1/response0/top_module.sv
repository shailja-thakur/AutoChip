module top_module (
    input [7:0] in,
    output [7:0] out
);
    reg [7:0] reverse;
    
    always @(*) begin
        reverse[0] = in[7];
        reverse[1] = in[6];
        reverse[2] = in[5];
        reverse[3] = in[4];
        reverse[4] = in[3];
        reverse[5] = in[2];
        reverse[6] = in[1];
        reverse[7] = in[0];
    end
    
    assign out = reverse;
    
endmodule
