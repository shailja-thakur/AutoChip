module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

reg [3:1] ena_temp; // Temporary variable to store the enable signals

always @(posedge clk or posedge reset) begin
    if(reset) begin
        q <= 16'd0;
        ena_temp <= 3'b0;
    end else begin
        if(q[3:0] == 4'b1001) begin
            q[3:0] <= 4'b0000;
            ena_temp[1] <= 1;
        end else begin
            ena_temp[1] <= 0;
        end
        
        if(q[7:4] == 4'b1001) begin
            q[7:4] <= 4'b0000;
            ena_temp[2] <= 1;
        end else begin
            ena_temp[2] <= 0;
        end
        
        if(q[11:8] == 4'b1001) begin
            q[11:8] <= 4'b0000;
            ena_temp[3] <= 1;
        end else begin
            ena_temp[3] <= 0;
        end
        
        if(q[15:12] == 4'b1001) begin
            q[15:12] <= 4'b0000;
        end
        
        if(q == 16'b1001100110011001) begin // Check if the counter reaches its maximum value
            q <= 16'd0;
        end else if(ena_temp != 3'b0) begin // Check if any of the upper three digits should be incremented
            q <= q + 1;
        end
    end
end

always @(posedge clk) begin
    ena <= ena_temp; // Assign the enable signals to the output
end

endmodule
