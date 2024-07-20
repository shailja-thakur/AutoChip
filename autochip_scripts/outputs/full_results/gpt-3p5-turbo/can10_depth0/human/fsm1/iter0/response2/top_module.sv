module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// Define the state register
reg [1:0] state;

// Define the state transitions and outputs
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01; // Reset to state B
    else begin
        case (state)
            2'b00: begin // State A, in=0
                if (in)
                    state <= 2'b00; // Stay in state A
                else
                    state <= 2'b01; // Transition to state B
            end
            2'b01: begin // State B, in=0
                if (in)
                    state <= 2'b01; // Stay in state B
                else
                    state <= 2'b00; // Transition to state A
            end
        endcase
    end
end

// Define the output
always @(state) begin
    if (state == 2'b01)
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
