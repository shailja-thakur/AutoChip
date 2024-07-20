module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states using local parameters
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    // Declare the state register
    reg [1:0] state, next_state;

    // Combinational logic block for determining the next state
    always @(*) begin
        case(state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A; // Default state
        endcase
    end

    // Sequential logic block for updating the current state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset state
        else
            state <= next_state;
    end

    // Output logic based on the current state
    always @(*) begin
        out = (state == D) ? 1'b1 : 1'b0;
    end

endmodule
