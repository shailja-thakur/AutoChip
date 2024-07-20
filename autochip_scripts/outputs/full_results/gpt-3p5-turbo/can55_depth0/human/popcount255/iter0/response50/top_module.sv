module top_module (
    input [254:0] in,
    output reg [7:0] out
);

always @(*)
begin
    // Initializing the output to zero 
    out = 0;
    
    // Iterating through all the bits in "in" and counting the number of '1's
    for(int i=0; i<255; i=i+1)
    begin
        if(in[i] == 1'b1)
            out = out + 8'b1;
    end
    
end
endmodule
