module top_module (
    input clk,
    input in,
    input reset,
    output reg out // Change to reg output
);

    // Defining states as a parameter
    parameter A = 0, B = 1, C = 2, D = 3;

    // Define internal state variable
    reg [1:0] state;

    // Next state logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else begin
            case(state)
                A: begin
                    if (in)
                        state <= B;
                    else
                        state <= A;
                end
                B: begin
                    if (in)
                        state <= B;
                    else
                        state <= C;
                end
                C: begin
                    if (in)
                        state <= D;
                    else
                        state <= A;
                end
                D: begin
                    if (in)
                        state <= B;
                    else
                        state <= C;
                end
            endcase
        end
    end

    // Output logic
    always @* begin // Change to always_comb
        if (state == D)
            out = 1;
        else
            out = 0;
    end

endmodule
