module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg overflow;
    reg [8:0] temp;

    always @* begin
        temp = a + b;
        
        if (temp > 127 || temp < -128) begin
            overflow = 1;
        end
        else begin
            overflow = 0;
        end
        
        s = temp[7:0];
    end

endmodule
