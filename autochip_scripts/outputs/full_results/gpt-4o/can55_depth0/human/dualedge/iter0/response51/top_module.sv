module top_module(
    input clk,
    input d,
    output reg q
);
    
    reg d_posedge;
    reg d_negedge;
    
    // Capture the value of D at the positive edge of the clock
    always @(posedge clk) begin
        d_posedge <= d;
    end
    
    // Capture the value of D at the negative edge of the clock
    always @(negedge clk) begin
        d_negedge <= d;
    end
    
    // Use a latch to capture data on both edges
    always @(clk or d_posedge or d_negedge) begin
        if (clk == 1'b1) begin
            q <= d_posedge;
        end else begin
            q <= d_negedge;
        end
    end
    
endmodule
