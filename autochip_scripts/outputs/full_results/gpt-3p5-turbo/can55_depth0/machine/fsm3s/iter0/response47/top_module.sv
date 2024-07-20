module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    /* Define the states using parameter */
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    /* Define registers for current state and next state */
    reg [1:0] state_reg, state_next;
    
    /* Assign initial state */
    always @(posedge clk or posedge reset) begin
        if (reset)
            state_reg <= A;
        else
            state_reg <= state_next;
    end
    
    /* Define state transitions and outputs */
    always @(state_reg or in) begin
        state_next = state_reg;
        
        case (state_reg)
            A: begin
                if (in)
                    state_next = B;
                else
                    state_next = A;
            end
            
            B: begin
                if (in)
                    state_next = B;
                else
                    state_next = C;
            end
            
            C: begin
                if (in)
                    state_next = D;
                else
                    state_next = A;
            end
            
            D: begin
                if (in)
                    state_next = B;
                else
                    state_next = C;
            end
        endcase
    end
    
    /* Define output */
    assign out = (state_reg == D) ? 1'b1 : 1'b0;

endmodule
