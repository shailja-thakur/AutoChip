module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
    );
    
    reg [3:0] q_temp;
    
    always @(posedge clk) begin
        if (reset) begin
            q_temp <= 0;
        end else begin
            if (ena[1]) begin
                q_temp[7:4] <= q_temp[7:4] + 1;
            end
            if (ena[2]) begin
                q_temp[11:8] <= q_temp[11:8] + 1;
            end
            if (ena[3]) begin
                q_temp[15:12] <= q_temp[15:12] + 1;
            end
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end else begin
            q <= {q_temp[15:12], q_temp[11:8], q_temp[7:4], q_temp[3:0]};
        end
    end
    
endmodule
