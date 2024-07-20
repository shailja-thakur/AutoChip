module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // Define the states as parameters
    parameter A = 0;
    parameter B = 1;
    
    // Define the state register
    reg [1:0] state;
    
    // Assign the initial state
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= A;
        else
            state <= state;
    end
    
    // Define the combinational logic
    always @(state or x)
    begin
        case (state)
            A: begin
                if (x)
                    state <= B;
                else
                    state <= A;
            end
            B: begin
                state <= B;
            end
        endcase
    end
    
    // Define the output z
    assign z = (state == A && x) || (state == B && !x);

endmodule
