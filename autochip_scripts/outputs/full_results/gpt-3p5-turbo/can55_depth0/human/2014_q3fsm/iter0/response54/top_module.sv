module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Declare state variable and current state register
    // 0 = A, 1 = B, 2 = Check1, 3 = Check2, 4 = Check3
    reg [2:0] state, next_state;
    
    // State assignment
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter Check1 = 3'b010;
    parameter Check2 = 3'b011;
    parameter Check3 = 3'b100;
    
    // State transition logic
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and output logic
    always @(state, s, w) begin
        next_state = state;
        z = 0; // Set default value of z to 0
        
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                end
            end
            
            B: begin
                next_state = Check1;
            end
            
            Check1: begin
                if (w) begin
                    next_state = Check2;
                end
            end
            
            Check2: begin
                if (w) begin
                    next_state = Check3;
                end
            end
            
            Check3: begin
                if (w) begin
                    z = 1; // Set z to 1 if w = 1 in exactly two of the three previous clock cycles
                end
                
                next_state = B;
            end
        endcase
    end

endmodule
