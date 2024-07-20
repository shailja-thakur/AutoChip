module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // Define the state register
    reg state;

    // Reset the state to B on synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            case (state)
                A: begin
                    if (in)
                        state <= A;
                    else
                        state <= B;
                end
                B: begin
                    if (in)
                        state <= B;
                    else
                        state <= A;
                end
            endcase
    end

    // Output logic
    always @(*)
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase

endmodule
