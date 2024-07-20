module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State register
    reg [1:0] state;
    
    // State definitions
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    
    // Next state logic
    always @(*)
    begin
        case (state)
            A: state = (in) ? B : A;
            B: state = (in) ? B : C;
            C: state = (in) ? D : A;
            D: state = (in) ? B : C;
            default: state = A;
        endcase
    end
    
    // Output logic
    always @(*)
    begin
        case (state)
            D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
    
    // State register update
    always @(posedge clk)
    begin
        if (reset)
            state <= A;
        else
            state <= state;
    end

endmodule
