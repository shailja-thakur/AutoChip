module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @* begin
    case (in)
        0:
            pos = 0;
        1:
            pos = 1;
        2:
            pos = 2;
        3:
            pos = 2;
        4:
            pos = 3;
        5: 
            pos = 3;
        6:
            pos = 3;
        7:
            pos = 3;
        8:
            pos = 4;
        9:
            pos = 4;
        10:
            pos = 4;
        11:
            pos = 4;
        12:
            pos = 4;
        13:
            pos = 4;
        14:
            pos = 4;
        15:
            pos = 4;
    endcase
end

endmodule
