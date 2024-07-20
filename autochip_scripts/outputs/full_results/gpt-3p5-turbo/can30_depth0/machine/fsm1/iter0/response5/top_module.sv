module top_module (
	input wire clk,
    input wire in,
    input wire areset,
    output wire out
);
    
    // Define states A and B
    parameter A = 0;
    parameter B = 1;
    
    // Define registers for current state and next state
    reg [1:0] current_state;
    reg [1:0] next_state;
    
    // Assign initial state B to current state
    always @(posedge areset)
        current_state <= B;
    
    // Assign next state based on current state and input 'in'
    always @*
    begin
        case(current_state)
            A: 
            begin
                if (in == 1'b1)
                    next_state = A;
                else
                    next_state = B;
            end
            
            B: 
            begin
                if (in == 1'b1)
                    next_state = B;
                else
                    next_state = A;
            end
        endcase
    end
    
    // Update current state with next state on the rising edge of clock 'clk'
    always @(posedge clk)
        current_state <= next_state;
    
    // Assign output 'out' based on current state
    assign out = (current_state == B) ? 1'b1 : 1'b0;

endmodule
