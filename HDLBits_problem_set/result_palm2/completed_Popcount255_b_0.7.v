module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    // Count the number of 1's in each 8-bit slice of the input vector.
    always @(posedge clk) begin
        for (int i = 0; i < 8; i++) begin
            reg [7:0] count = 0;
            for (int j = 7; j >= 0; j--) begin
                count += (in[i*8+j] == 1);
            end
            out[i] = count;
        end
    end
endmodule