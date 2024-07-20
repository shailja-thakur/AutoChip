module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define states as local parameters
    localparam A = 1'b0;
    localparam B = 1'b1;

    // State register
    reg state;

    // State transition and output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Asynchronous reset
        else begin
            case (state)
                A: if (x)
                       state <= B;
                   else
                       state <= A;
                B: state <= B;
                default: state <= A;
            endcase
        end
    end

    // Output logic based on the current state and input x
    always @(state or x) begin
        if ((state == A && x == 1) || (state == B && x == 0))
            z <= 1;
        else
            z <= 0;
    end

endmodule
