module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    reg [7:0] temp;
    integer i;
    
    always @* begin
        pos = 0;
        temp = in;
        
        for(i=0; i<8; i=i+1) begin
            if(temp[i] == 1) begin
                pos = i;
                break;
            end
        end
    end

endmodule
