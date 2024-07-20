module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // Define the states
    parameter OFF = 1'b0;
    parameter ON = 1'b1;
    
    reg state, next_state;

    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    always @(*)
    begin
        case (state)
            OFF:
                begin
                    if (j)
                        next_state = ON;
                    else
                        next_state = OFF;
                    
                    out <= 1'b0;
                end
            ON:
                begin
                    if (k)
                        next_state = OFF;
                    else
                        next_state = ON;
                    
                    out <= 1'b1;
                end
        endcase
    end
endmodule
