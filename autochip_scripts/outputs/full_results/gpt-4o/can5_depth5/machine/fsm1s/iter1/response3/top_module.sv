module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state;
    reg next_state;

    // Combinational logic for state transition
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;
        endcase
    end

    // Sequential logic to update state register
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output assignment
    always @(*) begin
        out = (state == B);
    end
endmodule
