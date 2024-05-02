module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    reg [254:0] count;
    
    always @(posedge clk) begin
        count <= 0;
        for (int i = 0; i < 255; i++) begin
            count <= count + (in[i] ? 1 : 0);
        end
        out <= count;
    end
endmodule