module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    reg [1:0] state, next_state;
    
    always @(posedge clk)
    begin
        if (reset)
            state <= 2'b00; // State A
        else
            state <= next_state;
    end
    
    always @(*)
    begin
        case (state)
            2'b00: // State A
                begin
                    if (in)
                        next_state = 2'b01; // Next state is B (in=1)
                    else
                        next_state = 2'b00; // Next state is A (in=0)
                    out = 1'b0; // Output is 0
                end
                
            2'b01: // State B
                begin
                    if (in)
                        next_state = 2'b01; // Next state is B (in=1)
                    else
                        next_state = 2'b10; // Next state is C (in=0)
                    out = 1'b0; // Output is 0
                end
                
            2'b10: // State C
                begin
                    if (in)
                        next_state = 2'b11; // Next state is D (in=1)
                    else
                        next_state = 2'b00; // Next state is A (in=0)
                    out = 1'b0; // Output is 0
                end
                
            2'b11: // State D
                begin
                    if (in)
                        next_state = 2'b10; // Next state is C (in=1)
                    else
                        next_state = 2'b01; // Next state is B (in=0)
                    out = 1'b1; // Output is 1
                end
        endcase
    end
endmodule
