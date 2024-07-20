module top_module(
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b10;
        out <= 1'b1;
    end else begin
        case(state)
            2'b00: begin // B state
                if (in)
                    state <= 2'b01; // Transition to A state
                else
                    state <= 2'b00; // Remain in B state
                out <= 1'b1; // Output is 1 in B state
            end
            2'b01: begin // A state
                if (in)
                    state <= 2'b01; // Remain in A state
                else
                    state <= 2'b00; // Transition to B state
                out <= 1'b0; // Output is 0 in A state
            end
            default: begin // Invalid state
                state <= 2'b00; // Return to default B state
                out <= 1'b1; // Output is 1 in invalid state
            end
        endcase
    end
end

endmodule
