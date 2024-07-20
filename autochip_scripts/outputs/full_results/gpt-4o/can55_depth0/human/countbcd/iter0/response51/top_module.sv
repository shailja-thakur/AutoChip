module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);
    
    wire inc_ena1, inc_ena2, inc_ena3;

    // Enable signals
    assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = ena[1] & (q[7:4] == 4'd9);
    assign ena[3] = ena[2] & (q[11:8] == 4'd9);
    
    // Increment signals
    assign inc_ena1 = ena[1];
    assign inc_ena2 = ena[2];
    assign inc_ena3 = ena[3];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end 
        else begin
            // Ones place
            if (q[3:0] == 4'd9) 
                q[3:0] <= 4'd0;
            else 
                q[3:0] <= q[3:0] + 4'd1;
            
            // Tens place
            if (inc_ena1) begin
                if (q[7:4] == 4'd9) 
                    q[7:4] <= 4'd0;
                else 
                    q[7:4] <= q[7:4] + 4'd1;
            end
            
            // Hundreds place
            if (inc_ena2) begin
                if (q[11:8] == 4'd9) 
                    q[11:8] <= 4'd0;
                else 
                    q[11:8] <= q[11:8] + 4'd1;
            end
            
            // Thousands place
            if (inc_ena3) begin
                if (q[15:12] == 4'd9) 
                    q[15:12] <= 4'd0;
                else 
                    q[15:12] <= q[15:12] + 4'd1;
            end
        end
    end
endmodule
