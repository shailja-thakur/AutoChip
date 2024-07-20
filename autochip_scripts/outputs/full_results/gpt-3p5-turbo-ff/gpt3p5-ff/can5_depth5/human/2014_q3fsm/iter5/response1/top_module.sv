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
        else if (state == 2'b01 && w)
            state <= 2'b10;  // Move to state C
        else if (state == 2'b10 && count == 3'b111)
            state <= 2'b01;  // Move back to state B
        else
            state <= state;
    end
    
    // Check w conditions
    always @(posedge clk) begin
        if (reset)
            count <= 3'b000;  // Reset count
        else if (state == 2'b01)
            count <= {count[1:0], w};  // Shift count with w input
        else if (state == 2'b10)
            count <= count + 1'b1;  // Increment count in state C
        else
            count <= count;
    end
    
    // Set output z
    always @(posedge clk) begin
        if (reset)
            z <= 1'b0;  // Reset output z to 0
        else if (state == 2'b01 && count == 3'b110)
            z <= 1'b1;  // Set output z to 1
        else
            z <= 1'b0;  // Set output z to 0
    end
    
endmodule
