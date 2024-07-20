module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    
    always @(*) begin
        if (in[0] == 1'b1) pos = 3'b0;
        else if (in[1] == 1'b1) pos = 3'b1;
        else if (in[2] == 1'b1) pos = 3'b2;
        else if (in[3] == 1'b1) pos = 3'b3;
        else if (in[4] == 1'b1) pos = 3'b4;
        else if (in[5] == 1'b1) pos = 3'b5;
        else if (in[6] == 1'b1) pos = 3'b6;
        else if (in[7] == 1'b1) pos = 3'b7;
        else pos = 3'b0;
    end
endmodule
