module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    always @(*) begin
        for (pos=0; pos<8; pos=pos+1) begin
            if (in[pos] == 1'b1) begin
                break;
            end
        end
    end
    
endmodule
