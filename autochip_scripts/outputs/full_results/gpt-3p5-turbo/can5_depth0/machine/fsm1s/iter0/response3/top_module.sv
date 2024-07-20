module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset)
            state <= 2'b10; // initializing state to B
        else if (state == 2'b00 && in)
            state <= 2'b00; // Transition from A to A
        else if (state == 2'b00 && !in)
            state <= 2'b01; // Transition from A to B
        else if (state == 2'b01 && in)
            state <= 2'b01; // Transition from B to B
        else if (state == 2'b01 && !in)
            state <= 2'b00; // Transition from B to A
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
endmodule
