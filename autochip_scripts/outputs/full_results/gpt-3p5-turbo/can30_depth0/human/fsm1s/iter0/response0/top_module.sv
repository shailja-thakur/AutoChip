module top_module (
    input clk,
    input in,
    input reset,
    output out
);

// Define the states as constants
parameter B = 0;
parameter A = 1;

// Define the state register and the next state
reg [1:0] state_reg, next_state;

always@(posedge clk or posedge reset)
begin
    if (reset)
        state_reg <= B;
    else
        state_reg <= next_state;
end

always@(state_reg or in)
begin
    case (state_reg)
        B: begin
            if (in)
                next_state = B;
            else
                next_state = A;
            
            out = 1;
        end
        
        A: begin
            if (in)
                next_state = A;
            else
                next_state = B;
            
            out = 0;
        end
    endcase
end

endmodule
