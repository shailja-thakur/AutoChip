module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Parameterized register to store the current state
    reg [1:0] state; // Two-state state machine (A and B)

    // Combinational logic block to determine next state
    always @(*) begin
        if (state == 2'b00) begin // If current state is A
            if (in) begin // If in input is high
                state <= 2'b00; // Next state is A
            end else begin // If in input is low
                state <= 2'b01; // Next state is B
            end
        end else begin // If current state is B
            if (in) begin // If in input is high
                state <= 2'b01; // Next state is B
            end else begin // If in input is low
                state <= 2'b00; // Next state is A
            end
        end
    end

    // Always block triggered on the rising edge of clk
    always @(posedge clk) begin
        if (reset) begin // If reset input is high
            state <= 2'b01; // Reset state to B
        end else begin
            state <= next_state; // Update state with next state determined by combinational logic block
        end
    end

    // Assign out output with the value of the state register
    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // If state is B, out is high, otherwise it is low

endmodule
