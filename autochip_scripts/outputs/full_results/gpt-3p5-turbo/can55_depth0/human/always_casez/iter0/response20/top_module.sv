module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    pos = 0;

    for (integer i=0; i<8; i=i+1) begin
        if (in[i] == 1'b1) begin
            pos = i;
            break;
        end
    end
end

endmodule
