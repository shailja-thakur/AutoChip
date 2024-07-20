module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    // State encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    reg [1:0] state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A; // Default state to handle unexpected cases
        endcase
    end

    // Sequential logic to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset to state A
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
