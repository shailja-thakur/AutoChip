module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    if (in == 8'b0) begin
        pos = 3'b0;
    end
    else if (in[0]) begin
        pos = 3'b0;
    end
    else if (in[1]) begin
        pos = 3'b1;
    end
    else if (in[2]) begin
        pos = 3'b2;
    end
    else if (in[3]) begin
        pos = 3'b3;
    end
    else if (in[4]) begin
        pos = 3'b4;
    end
    else if (in[5]) begin
        pos = 3'b5;
    end
    else if (in[6]) begin
        pos = 3'b6;
    end
    else if (in[7]) begin
        pos = 3'b7;
    end
end

endmodule
