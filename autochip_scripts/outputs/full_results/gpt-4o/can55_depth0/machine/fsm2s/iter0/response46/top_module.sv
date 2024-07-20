module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    
    // State encoding
    localparam A = 1'b0;
    localparam B = 1'b1;
    
    reg state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: if (j) 
                    next_state = B;
               else
                    next_state = A;
            B: if (k)
                    next_state = A;
               else
                    next_state = B;
            default: 
                next_state = A;
        endcase
    end
    
    // State and output update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
        
        out <= (state == B);
    end
    
endmodule
