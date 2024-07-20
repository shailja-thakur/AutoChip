module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] temp_s;
    reg overflow;

    always @(*) begin
        temp_s = a + b;
        if (temp_s[8] == 1) begin
            overflow = 1;
            s = temp_s[7:0];
        end else begin
            overflow = 0;
            s = temp_s[7:0];
        end
    end

endmodule
