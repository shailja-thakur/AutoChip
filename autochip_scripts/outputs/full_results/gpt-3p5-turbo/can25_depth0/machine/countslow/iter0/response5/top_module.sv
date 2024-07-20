module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
    );
    
    always @(posedge clk)
    begin
        if(reset) // check if reset signal is asserted
        begin
            q <= 0; // reset counter to 0
        end
        else if(slowena) // check if slowena signal is asserted
        begin
            if(q == 9) // check if counter is equal to 9
            begin
                q <= 0; // reset counter to 0
            end
            else
            begin
                q <= q + 1; // increment counter by 1
            end
        end
    end

endmodule
