module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    always @(*) begin
        pos = 3'd0;  // Default value for pos
        if (in[0] == 1)
            pos = 3'd0;
        else if (in[1] == 1)
            pos = 3'd1;
        else if (in[2] == 1)
            pos = 3'd2;
        else if (in[3] == 1)
            pos = 3'd3;
        else if (in[4] == 1)
            pos = 3'd4;
        else if (in[5] == 1)
            pos = 3'd5;
        else if (in[6] == 1)
            pos = 3'd6;
        else if (in[7] == 1)
            pos = 3'd7;
    end
endmodule
