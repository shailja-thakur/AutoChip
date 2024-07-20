module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            q <= 4'b0000; // Reset counter to 0
        end
        else begin
            if(q == 4'b1111) begin
                q <= 4'b0000; // Reset counter when it reaches 15
            end
            else begin
                q <= q + 1; // Increment counter
            end
        end
    end

endmodule
