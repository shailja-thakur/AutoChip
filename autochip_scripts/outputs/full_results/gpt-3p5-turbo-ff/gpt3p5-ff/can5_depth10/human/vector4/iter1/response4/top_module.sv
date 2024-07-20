module top_module (
    input [7:0] in,
    output reg [31:0] out
);
    
    always @(*) begin
        out[31:8] = {24{in[7]}};
        out[7:0] = in;
    end
    
endmodule
