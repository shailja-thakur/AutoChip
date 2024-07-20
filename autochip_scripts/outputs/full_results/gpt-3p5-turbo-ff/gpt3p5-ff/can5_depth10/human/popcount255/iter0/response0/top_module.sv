module top_module (
    input [254:0] in,
    output reg [7:0] out
);
    always @(*) begin
        integer i;
        reg [7:0] count;

        count = 0;

        for (i = 0; i <= 254; i = i + 1) begin
            if (in[i] == 1'b1)
                count = count + 1;
        end

        out = count;
    end
endmodule
