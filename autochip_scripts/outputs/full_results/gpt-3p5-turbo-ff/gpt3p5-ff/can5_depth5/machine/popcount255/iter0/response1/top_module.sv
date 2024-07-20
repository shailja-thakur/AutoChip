module top_module (
    input [254:0] in,
    output reg [7:0] out
);
    reg [7:0] temp;
    always_comb begin
        temp = 0;
        for (int i = 0; i < 255; i = i + 1) begin
            temp = temp + in[i];
        end
        out = temp;
    end
endmodule
