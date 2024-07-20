module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // Parameters for state machine states
    parameter A = 0;
    parameter B = 1;

    // State register
    reg [1:0] state;

    // Next state logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else begin
            case (state)
                A: if (x) state <= B;
                   else state <= A;
                B: state <= B;
            endcase
        end
    end

    // Output logic
    assign z = (state == A && x) || (state == B && !x);

endmodule
