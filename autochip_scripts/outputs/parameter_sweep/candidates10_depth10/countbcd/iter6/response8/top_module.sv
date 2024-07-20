module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

reg [3:0] q_temp;    // Create a temporary register for q

always @(posedge clk) begin
    if(reset) begin
        q <= 16'd0;
        ena <= 3'b0;
    end else begin
        q_temp <= q;    // Store the current value of q in q_temp
        
        // Increment the respective digits based on enable signals
        if(q_temp[3:0] == 4'd9 && ena[1]) begin
            q[3:0] <= 4'd0;
            ena[1] <= 1'b0;
        end else if (q_temp[3:0] != 4'd9 && ena[1]) begin
            q[3:0] <= q_temp[3:0] + 1;
        end
        
        if (q_temp[3:0] != 4'd9 && !ena[1] && q_temp[7:4] != 4'd9 && ena[2]) begin
            q[3:0] <= q_temp[3:0] + 1;
        end
        
        if (q_temp[3:0] == 4'd9 && !ena[1] && q_temp[7:4] != 4'd9 && ena[2]) begin
            q[3:0] <= 4'd0;
            ena[1] <= 1'b1;
        end
        
        if (q_temp[7:4] != 4'd9 && !ena[2] && q_temp[11:8] != 4'd9 && ena[3]) begin
            q[3:0] <= q_temp[3:0] + 1;
        end
        
        if (q_temp[7:4] == 4'd9 && !ena[2] && q_temp[11:8] != 4'd9 && ena[3]) begin
            q[7:4] <= q_temp[7:4] + 1;
            q[3:0] <= 4'd0;
            ena[1] <= 1'b1;
        end
        
        if (q_temp[11:8] != 4'd9 && !ena[3] && q_temp[15:12] != 4'd9) begin
            q[3:0] <= q_temp[3:0] + 1;
        end
        
        if (q_temp[11:8] == 4'd9 && !ena[3] && q_temp[15:12] != 4'd9) begin
            q[11:8] <= q_temp[11:8] + 1;
            q[7:4] <= 4'd0;
            ena[2] <= 1'b1;
        end
    end
end

endmodule
