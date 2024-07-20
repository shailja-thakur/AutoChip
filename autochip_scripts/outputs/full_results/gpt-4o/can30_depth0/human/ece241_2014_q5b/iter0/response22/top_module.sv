module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
  
    reg [1:0] state, next_state;
    
    // State encoding
    localparam A = 2'b01, B = 2'b10;
    
    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
                else next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: z = x;          // z = 0 when x=0, z = 1 when x=1
            B: z = ~x;         // z = 1 when x=0, z = 0 when x=1
            default: z = 0;
        endcase
    end
  
endmodule
