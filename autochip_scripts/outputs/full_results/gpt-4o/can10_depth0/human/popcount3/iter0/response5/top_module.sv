module top_module (
    input [2:0] in,
    output [1:0] out
);
    integer i;
    reg [1:0] count;
    
    always @(*) begin
        count = 2'b00; // Initialize count to 0
        for (i = 0; i < 3; i = i + 1) begin
            count = count + in[i];
        end
    end
    
    assign out = count;
endmodule
