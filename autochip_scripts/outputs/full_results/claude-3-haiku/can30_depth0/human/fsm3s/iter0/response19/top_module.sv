module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the state variables
    reg [1:0] state, next_state;

    // Define the state transitions
    always @(*) begin
        case (state)
            2'b00: next_state = in ? 2'b01 : 2'b00;
            2'b01: next_state = in ? 2'b01 : 2'b10;
            2'b10: next_state = in ? 2'b11 : 2'b00;
            2'b11: next_state = in ? 2'b01 : 2'b10;
        endcase
    end

    // Define the output logic
    always @(*) begin
        case (state)
            2'b00, 2'b01, 2'b10: out = 1'b0;
            2'b11: out = 1'b1;
        endcase
    end

    // Update the state on the clock edge
    always @(posedge clk) begin
        if (reset) state <= 2'b00;
        else state <= next_state;
    end

endmodule
