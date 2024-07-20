module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] temp;
    
    always @(*) begin
        temp = a + b;
        
        if (temp[8] == 1)
            overflow = 1;
        else
            overflow = 0;
        
        s = temp[7:0];
    end

endmodule
