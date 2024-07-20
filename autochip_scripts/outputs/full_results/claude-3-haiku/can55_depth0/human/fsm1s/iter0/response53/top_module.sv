module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the state variables
reg state_A, state_B;

// Next state and output logic
always @(posedge clk) begin
    if (reset) begin
        // Reset to state B
        state_A <= 1'b0;
        state_B <= 1'b1;
        out <= 1'b1;
    end
    else begin
        case ({state_A, state_B, in})
            3'b100: begin // A, in=0
                state_A <= 1'b0;
                state_B <= 1'b1;
                out <= 1'b1;
            end
            3'b101: begin // A, in=1
                state_A <= 1'b1;
                state_B <= 1'b0;
                out <= 1'b0;
            end
            3'b011: begin // B, in=0
                state_A <= 1'b0;
                state_B <= 1'b1;
                out <= 1'b1;
            end
            3'b111: begin // B, in=1
                state_A <= 1'b1;
                state_B <= 1'b1;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
