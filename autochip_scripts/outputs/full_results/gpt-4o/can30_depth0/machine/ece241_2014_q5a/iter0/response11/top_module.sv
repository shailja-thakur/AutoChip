module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    // Define states using parameters
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    // State register
    reg [1:0] state, next_state;
    
    // Sequential logic: on positive edge of clock or active-high reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;       // Reset state to A
        end else begin
            state <= next_state;  // Update state
        end
    end
    
    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: begin
                if (x) next_state = C;
                else next_state = A;
            end 
            B: begin
                if (x) next_state = B;
                else next_state = C;
            end 
            C: begin
                if (x) next_state = B;
                else next_state = C;
            end 
            default: next_state = A; // Default state
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            C: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
    
endmodule
