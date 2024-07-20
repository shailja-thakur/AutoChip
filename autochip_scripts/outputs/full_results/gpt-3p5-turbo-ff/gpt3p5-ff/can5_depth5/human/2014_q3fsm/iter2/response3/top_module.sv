module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    // Declare state signals
    reg [1:0] state;
    reg [2:0] count;
    
    // Assign initial values
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;  // Reset state A
        else if (state == 2'b00 && s)
            state <= 2'b01;  // Move to state B
        else if (state == 2'b01 && count == 3)
            state <= 2'b00;  // Move back to state A
        else
            state <= state;
    end
    
    reg [2:0] wCount;  // Keeps track of the number of '1's in w
    
    always @(posedge clk) begin
        if (state == 2'b01) begin
            wCount <= {wCount[1:0], w};  // Shift in w to keep track of the last three inputs
            
            if (count == 3) begin
                if (wCount[2] + wCount[1] == 2)  // Check if exactly two '1's occurred in the last three cycles
                    z <= 1;  // Set output z to 1
                else
                    z <= 0;  // Set output z to 0
                
                count <= 0;      // Reset count
                wCount <= 3'b000;  // Reset wCount
            end
            else begin
                count <= count + 1;
            end
        end
        else begin
            count <= 0;
            wCount <= 3'b000;  // Reset wCount
        end
    end
    
endmodule
