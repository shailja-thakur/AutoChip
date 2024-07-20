module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    always @* begin
        integer i;
        reg [7:0] count;
        
        count = 8'b0;
        
        for (i = 0; i < 255; i = i + 1) begin
            if (in[i] == 1'b1) begin
                count = count + 1'b1;
            end
        end
        
        out = count;
    end
endmodule
