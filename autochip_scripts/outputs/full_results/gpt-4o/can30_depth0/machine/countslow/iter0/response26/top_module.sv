module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (slowena) begin
            if (q == 4'b1001) begin // check if counter is 9
                q <= 4'b0000; // reset counter to 0
            end else begin
                q <= q + 4'b0001; // increment counter 
            end
        end
    end
endmodule
