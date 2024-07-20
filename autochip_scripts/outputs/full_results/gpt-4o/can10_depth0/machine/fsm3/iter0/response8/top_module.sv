module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    // Define state parameters
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // State register to hold the current state
    reg [1:0] state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A; // Default to state A for safety
        endcase
    end

    // Sequential logic to update state on the rising edge of clk or areset
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == D);
endmodule
