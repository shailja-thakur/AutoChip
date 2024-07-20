module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    
    // State register
    reg [1:0] state, next_state;

    // Next state logic
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
    assign out = (state == D);

    // State register update
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
