module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Parameterized register to store the current state of the state machine
    reg [1:0] state;

    // Combinational logic block to determine the next state
    always @* begin
        case (state)
            2'd0: if (in) state = 2'd0; else state = 2'd1;
            2'd1: if (in) state = 2'd1; else state = 2'd0;
        endcase
    end

    // Always block triggered on the rising edge of the clk input
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'd1; // Reset to the initial state, B
        end else begin
            state <= next_state; // Update state with next state determined by combinational logic block
        end
    end

    // Assign the value of the state register to the out output
    assign out = (state == 2'd1) ? 1'b1 : 1'b0;

endmodule
