module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);
    
    reg [7:0] q_temp; // Temporary storage for delayed q value
    
    always @(negedge clk) begin
        if (reset)
            q_temp <= 8'h34; // Reset value to 0x34
        else
            q_temp <= d;
    end
    
    always @(posedge clk) begin
        q <= q_temp;
    end
    
endmodule
