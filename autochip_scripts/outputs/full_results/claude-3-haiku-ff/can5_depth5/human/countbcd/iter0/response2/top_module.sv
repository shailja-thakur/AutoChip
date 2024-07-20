module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0; // Reset all digits to 0
    end
    else begin
        q[3:0] <= q[3:0] + 1'b1; // Increment ones digit
        
        if (q[3:0] == 4'b1010) begin // Ones digit reached 10
            q[3:0] <= 4'b0; // Reset ones digit to 0
            ena[1] <= 1'b1; // Enable increment of tens digit
        end
        else begin
            ena[1] <= 1'b0;
        end
        
        if (ena[1]) begin
            q[7:4] <= q[7:4] + 1'b1; // Increment tens digit
            
            if (q[7:4] == 4'b1010) begin // Tens digit reached 10
                q[7:4] <= 4'b0; // Reset tens digit to 0
                ena[2] <= 1'b1; // Enable increment of hundreds digit
            end
            else begin
                ena[2] <= 1'b0;
            end
        end
        else begin
            ena[2] <= 1'b0;
        end
        
        if (ena[2]) begin
            q[11:8] <= q[11:8] + 1'b1; // Increment hundreds digit
            
            if (q[11:8] == 4'b1010) begin // Hundreds digit reached 10
                q[11:8] <= 4'b0; // Reset hundreds digit to 0
                ena[3] <= 1'b1; // Enable increment of thousands digit
            end
            else begin
                ena[3] <= 1'b0;
            end
        end
        else begin
            ena[3] <= 1'b0;
        end
        
        if (ena[3]) begin
            q[15:12] <= q[15:12] + 1'b1; // Increment thousands digit
        end
    end
end

endmodule
