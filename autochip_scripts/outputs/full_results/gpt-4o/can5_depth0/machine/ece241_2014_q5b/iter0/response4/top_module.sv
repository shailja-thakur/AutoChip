module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define the states
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // State transition logic (sequential part)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // Asynchronous reset
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic (combinational part)
    always @(*) begin
        case (state)
            A: if (x) next_state = B; else next_state = A;
            B: next_state = B;
        endcase
    end
    
    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
        end else begin
            if ((state == A && x) || (state == B && !x)) begin
                z <= 1'b1;
            end else begin
                z <= 1'b0;
            end
        end
    end
endmodule
