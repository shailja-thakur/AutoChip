module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b0; // Initial state is OFF
        else begin
            case (state)
                2'b00: begin // OFF state
                    if (j)
                        state <= 2'b01; // Transition to ON state when j=1
                    else
                        state <= 2'b00; // Remain in OFF state when j=0
                end
                2'b01: begin // ON state
                    if (k)
                        state <= 2'b00; // Transition to OFF state when k=1
                    else
                        state <= 2'b01; // Remain in ON state when k=0
                end
                default: begin
                    state <= 2'b0; // Reset to OFF state if unexpected state
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: out <= 1'b0; // Set output to 0 when in OFF state
            2'b01: out <= 1'b1; // Set output to 1 when in ON state
            default: out <= 1'b0; // Set output to 0 by default
        endcase
    end
endmodule
