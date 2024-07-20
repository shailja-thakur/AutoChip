module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
        end else begin
            // Increment ones digit if enabled
            if (ena[1]) begin
                if (q[3:0] < 9) begin
                    q[3:0] <= q[3:0] + 1;
                end else begin
                    q[3:0] <= 0;
                end
            end
            
            // Increment tens digit if enabled
            if (ena[2]) begin
                if (q[7:4] < 9) begin
                    q[7:4] <= q[7:4] + 1;
                end else begin
                    q[7:4] <= 0;
                end
            end
            
            // Increment hundreds digit if enabled
            if (ena[3]) begin
                if (q[11:8] < 9) begin
                    q[11:8] <= q[11:8] + 1;
                end else begin
                    q[11:8] <= 0;
                end
            end
        end
    end

endmodule
