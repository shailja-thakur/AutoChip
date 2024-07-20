module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Define the states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    // Define the current state and next state variables
    reg [1:0] curr_state;
    reg [1:0] next_state;
    
    // Define the output reg
    reg out_reg;
    
    always @(posedge clk or posedge reset) begin
        // Reset the FSM
        if (reset) begin
            curr_state <= A;
        end
        // State transition logic
        else begin
            curr_state <= next_state;
        end
    end
    
    always @(curr_state, in) begin
        // Default next state and output value
        next_state = curr_state;
        out_reg = 0;
        
        // State transition logic based on current state and input
        case (curr_state)
            A: begin
                if (in) begin
                    next_state = B;
                end
            end
            
            B: begin
                if (in) begin
                    next_state = B;
                end
                else begin
                    next_state = C;
                end
            end
            
            C: begin
                if (in) begin
                    next_state = D;
                end
                else begin
                    next_state = A;
                end
            end
            
            D: begin
                if (in) begin
                    next_state = B;
                end
                else begin
                    next_state = C;
                end
            end
        endcase
    end
    
    always @(curr_state) begin
        // Logic for setting the output value
        if (curr_state == D) begin
            out_reg = 1;
        end
    end
    
    assign out = out_reg;

endmodule
