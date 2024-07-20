module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    // Define the states
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    reg state, next_state;
    
    // Clocked always block to update the state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Combinational always block to determine the next state
    always @(*) begin
        case(state)
            A: begin
                if (j) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (k) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
        endcase
    end
    
    // Assign the output based on the current state
    always @(*) begin
        if (state == B) begin
            out = 1'b1;
        end else begin
            out = 1'b0;
        end
    end
    
endmodule
