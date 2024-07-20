module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Parameterized register to store the current state
    parameter A = 1'b0, B = 1'b1;
    reg state;

    // Combinational logic to determine the next state
    always @(*) begin
        if (state == A) begin
            state = (in == 1'b1) ? A : B;
        end else begin // state == B
            state = (in == 1'b1) ? B : A;
        end
    end

    // Update the state register on the rising edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            state <= B; // Reset the state to the initial state B
        end else begin
            state <= state; // Update the state with the next state
        end
    end

    // Assign the output based on the current state
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
