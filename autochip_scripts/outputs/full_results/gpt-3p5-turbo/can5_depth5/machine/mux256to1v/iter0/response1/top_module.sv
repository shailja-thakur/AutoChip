module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    reg [3:0] temp;
    
    always @(*) begin
        temp = in[8*sel +: 4];
        out = temp;
    end
endmodule
