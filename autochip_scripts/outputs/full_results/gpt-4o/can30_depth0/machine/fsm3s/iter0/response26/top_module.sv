module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state, next_state;
    
    // State encoding
    localparam A = 2'b00,
               B = 2'b01,
               C = 2'b10,
               D = 2'b11;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A;  // Default state should be A in case of unexpected value
        endcase
    end
    
    // Output logic
    assign out = (state == D);

endmodule
