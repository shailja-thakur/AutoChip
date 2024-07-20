module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] temp_s;
    reg temp_overflow;
    
    always @(*) begin
        temp_s = a + b;
        if (temp_s[8] == 1) begin
            temp_overflow = 1;
        end else begin
            temp_overflow = 0;
        end
    end
    
    assign s = temp_s[7:0];
    assign overflow = temp_overflow;
    
endmodule
