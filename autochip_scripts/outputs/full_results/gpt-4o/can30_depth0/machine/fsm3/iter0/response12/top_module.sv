module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // Define states using local parameters
    localparam A = 2'b00,
               B = 2'b01,
               C = 2'b10,
               D = 2'b11;

    // State register
    reg [1:0] state, next_state;

    // Combinational logic for next state logic
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;
        endcase
    end

    // Sequential logic for state update and reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 0;
        else
            out <= (state == D) ? 1 : 0;
    end
endmodule
