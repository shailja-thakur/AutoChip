module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // Define the states using local parameters
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    
    // State registers
    reg [1:0] state, next_state;
    
    // State transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;  // Reset state to A
        end else begin
            state <= next_state;
        end
    end
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A;
        endcase
    end
    
    // Output logic
    always @(*) begin
        out = (state == D) ? 1'b1 : 1'b0;
    end

endmodule
