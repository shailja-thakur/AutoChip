module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    // Initializing the output position to zero
    pos = 3'b0;
    
    // Checking each bit of the input vector 
    for (int i = 0; i < 8; i = i+1) begin
        if (in[i] == 1'b1) begin
            pos = i;
            break;
        end
    end
end

endmodule
