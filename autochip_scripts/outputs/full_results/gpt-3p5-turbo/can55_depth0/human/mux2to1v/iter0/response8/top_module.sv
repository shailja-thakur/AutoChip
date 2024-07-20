module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);

    reg [99:0] temp; 
    
    always @(*) begin
        if (sel == 0)
            temp = a;
        else
            temp = b;
    end
    
    assign out = temp;
    
endmodule
