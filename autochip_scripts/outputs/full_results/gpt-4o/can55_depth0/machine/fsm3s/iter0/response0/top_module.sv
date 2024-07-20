module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define states using localparam
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    
    // State and Next state variables
    reg [1:0] state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (state)
            A: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
                out = 0;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
                out = 0;
            end
            C: begin
                if (in)
                    next_state = D;
                else
                    next_state = A;
                out = 0;
            end
            D: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
                out = 1;
            end
            default: begin
                next_state = A;
                out = 0;
            end
        endcase
    end

endmodule
