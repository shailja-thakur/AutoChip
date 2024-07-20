module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);
    
    // Internal variables for digit counters
    reg [3:0] digit1;
    reg [3:0] digit2;
    reg [3:0] digit3;
    reg [3:0] digit4;
    
    // Internal signals for enable logic
    wire enable2;
    wire enable3;
    wire enable4;
    
    // Increment enable logic
    assign enable2 = ena[1] && (digit2 == 9);
    assign enable3 = ena[2] && (digit3 == 9) && enable2;
    assign enable4 = (digit4 == 9) && enable3;
    
    always @(posedge clk) begin
        if (reset) begin
            // Reset all digit counters and outputs
            digit1 <= 0;
            digit2 <= 0;
            digit3 <= 0;
            digit4 <= 0;
            q <= 0;
        end else begin
            // Increment digit counters
            if (enable2)
                digit2 <= digit2 + 1;
            if (enable3)
                digit3 <= digit3 + 1;
            if (enable4)
                digit4 <= digit4 + 1;
            
            // Update output based on digit counters
            q[3:0] <= digit1;
            q[7:4] <= digit2;
            q[11:8] <= digit3;
            q[15:12] <= digit4;
        end
    end
    
endmodule
