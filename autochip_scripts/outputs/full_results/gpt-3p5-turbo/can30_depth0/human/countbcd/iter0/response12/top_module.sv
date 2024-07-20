module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            if (ena[1]) begin // increment tens digit when ena[1] is high
                if (q[7:4] == 9) begin
                    q[7:4] <= 0;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                end
            end
            
            if (ena[2]) begin // increment hundreds digit when ena[2] is high
                if (q[11:8] == 9) begin
                    q[11:8] <= 0;
                end else begin
                    q[11:8] <= q[11:8] + 1;
                end
            end
            
            if (ena[3]) begin // increment thousands digit when ena[3] is high
                if (q[15:12] == 9) begin
                    q[15:12] <= 0;
                end else begin
                    q[15:12] <= q[15:12] + 1;
                end
            end
            
            if (q[3:0] == 9) begin // increment ones digit
                q[3:0] <= 0;
            end else begin
                q[3:0] <= q[3:0] + 1;
            end
        end
    end
endmodule
