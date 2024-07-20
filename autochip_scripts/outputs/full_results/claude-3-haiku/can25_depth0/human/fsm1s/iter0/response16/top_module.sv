module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the state variables
reg state_A, state_B;

// Initialize the states
initial begin
    state_A = 0;
    state_B = 1;
end

// Update the state and output
always @(posedge clk) begin
    if (reset) begin
        state_B <= 1;
        state_A <= 0;
    end
    else begin
        case ({state_A, state_B, in})
            3'b100: begin // A, in=0
                state_B <= 1;
                state_A <= 0;
                out <= 1;
            end
            3'b101: begin // A, in=1
                state_A <= 1;
                state_B <= 0;
                out <= 0;
            end
            3'b010: begin // B, in=0
                state_B <= 1;
                state_A <= 0;
                out <= 1;
            end
            3'b011: begin // B, in=1
                state_B <= 1;
                state_A <= 0;
                out <= 1;
            end
        endcase
    end
end

endmodule
