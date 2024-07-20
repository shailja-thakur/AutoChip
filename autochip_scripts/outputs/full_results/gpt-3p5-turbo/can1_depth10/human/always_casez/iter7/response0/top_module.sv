module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    always @(*) begin
        if (in[0]) pos = 0;
        else if (in[1]) pos = 1;
        else if (in[2]) pos = 2;
        else if (in[3]) pos = 3;
        else if (in[4]) pos = 4;
        else if (in[5]) pos = 5;
        else if (in[6]) pos = 6;
        else if (in[7]) pos = 7;
        else pos = 0;
    end

endmodule
