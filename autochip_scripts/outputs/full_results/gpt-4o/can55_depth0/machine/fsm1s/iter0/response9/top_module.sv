module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state parameters
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B; // Default state
        endcase
    end

    // Sequential block to update state on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B; // Reset state
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
