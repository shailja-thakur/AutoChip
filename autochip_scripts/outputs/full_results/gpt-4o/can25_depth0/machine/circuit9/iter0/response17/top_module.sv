module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1)
            q <= 3'b100; // set q to 4
        else if (a == 0) begin
            if (q == 3'b110) // if q is 6
                q <= 3'b000; // set q to 0
            else
                q <= q + 3'b001; // increment q by 1
        end
    end
    
endmodule
