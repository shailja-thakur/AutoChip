module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end
    else begin
        // Increment the ones digit
        q[3:0] <= q[3:0] + 1;
        
        // Check if the ones digit has rolled over to 0
        if (q[3:0] == 0) begin
            // Increment the tens digit
            q[7:4] <= q[7:4] + 1;
            ena[1] = 1;
        end
        else begin
            ena[1] = 0;
        end
        
        // Check if the tens digit has rolled over to 0
        if (q[7:4] == 0) begin
            // Increment the hundreds digit
            q[11:8] <= q[11:8] + 1;
            ena[2] = 1;
        end
        else begin
            ena[2] = 0;
        end
        
        // Check if the hundreds digit has rolled over to 0
        if (q[11:8] == 0) begin
            // Increment the thousands digit
            q[15:12] <= q[15:12] + 1;
            ena[3] = 1;
        end
        else begin
            ena[3] = 0;
        end
    end
end

endmodule
