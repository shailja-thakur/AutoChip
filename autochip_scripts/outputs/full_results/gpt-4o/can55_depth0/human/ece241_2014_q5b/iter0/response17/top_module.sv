module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    reg [1:0] state, next_state;
    
    // State Encoding
    parameter A = 2'b01, B = 2'b10;
    
    // State Transition Logic (Combinational)
    always @(*) begin
        case (state)
            A: if (x) begin
                    next_state = B;
                    z = 1;
               end else begin
                    next_state = A;
                    z = 0;
               end
            B: if (x) begin
                    next_state = B;
                    z = 0;
               end else begin
                    next_state = B;
                    z = 1;
               end
            default: begin
                    next_state = A;
                    z = 0;
               end
        endcase
    end
    
    // State Register (Sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
endmodule
