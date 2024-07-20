module top_module (
    input [254:0] in,
    output reg [7:0] out
);

reg [7:0] temp_count;
integer i;

always @(*) begin
    temp_count = 0;
    for (i = 0; i < 255; i = i + 1) begin
        if (in[i]) begin
            temp_count = temp_count + 1;
        end
    end
    out = temp_count;
end

endmodule
