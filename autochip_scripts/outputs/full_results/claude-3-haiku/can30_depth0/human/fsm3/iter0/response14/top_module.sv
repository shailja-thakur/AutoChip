module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the state variables
    reg [1:0] state, next_state;

    // State definitions
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
        endcase
    end

    // Combinational logic for output
    always @(*) begin
        case (state)
            D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

endmodule
