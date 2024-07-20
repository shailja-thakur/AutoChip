module top_module (
    input [99:0] in,
    output reg [99:0] out
);

always @(*) begin
    out = in;
    for (int i = 0; i < 50; i++) begin
        swap(out[i], out[99-i]);
    end
end

task swap(inout bit a, inout bit b);
    bit temp = a;
    a = b;
    b = temp;
endtask

endmodule
