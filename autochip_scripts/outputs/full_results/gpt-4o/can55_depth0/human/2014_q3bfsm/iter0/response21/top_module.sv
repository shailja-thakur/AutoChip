module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] y, Y; // Present state, next state

    // State transition logic
    always @(*) begin
        case (y)
            3'b000: Y = (x) ? 3'b001 : 3'b000;
            3'b001: Y = (x) ? 3'b100 : 3'b001;
            3'b010: Y = (x) ? 3'b001 : 3'b010;
            3'b011: Y = (x) ? 3'b010 : 3'b001;
            3'b100: Y = (x) ? 3'b100 : 3'b011;
            default: Y = 3'b000; // Default to 000 for undefined states
        endcase
    end
    
    // State flip-flops
    always @(posedge clk) begin
        if (reset)
            y <= 3'b000; // Synchronous reset
        else
            y <= Y;
    end
    
    // Output logic
    always @(*) begin
        case (y)
            3'b011: z = 1;
            3'b100: z = 1;
            default: z = 0;
        endcase
    end

endmodule
