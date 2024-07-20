module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);
    // Internal increment flag
    reg [3:0] carry;

    // Compute enable signals for each nibble except the least significant digit
    assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = ena[1] & (q[7:4] == 4'd9);
    assign ena[3] = ena[2] & (q[11:8] == 4'd9);
    
    // Synchronous operations with respect to clock and reset
    always @(posedge clk) begin
        if (reset) begin
            q <= 16'h0000; // Reset counter
        end
        else begin
            // Ones place
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                carry[0] <= 1'b1;
            end
            else begin
                q[3:0] <= q[3:0] + 1'b1;
                carry[0] <= 1'b0;
            end
            
            // Tens place
            if (carry[0]) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    carry[1] <= 1'b1;
                end
                else begin
                    q[7:4] <= q[7:4] + 1'b1;
                    carry[1] <= 1'b0;
                end
            end
            
            // Hundreds place
            if (carry[1]) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    carry[2] <= 1'b1;
                end
                else begin
                    q[11:8] <= q[11:8] + 1'b1;
                    carry[2] <= 1'b0;
                end
            end
            
            // Thousands place
            if (carry[2]) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end
                else begin
                    q[15:12] <= q[15:12] + 1'b1;
                end
            end
        end
    end
endmodule
