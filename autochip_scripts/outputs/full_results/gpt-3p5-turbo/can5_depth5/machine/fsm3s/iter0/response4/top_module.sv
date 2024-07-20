module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Start from state A
            out <= 0;
        end else begin
            case(state)
                2'b00: begin // State A
                    if (in) state <= 2'b01; // Move to state B if in = 1
                    else state <= 2'b00; // Stay in state A
                end
                2'b01: begin // State B
                    if (in) state <= 2'b01; // Stay in state B if in = 1
                    else state <= 2'b10; // Move to state C if in = 0
                end
                2'b10: begin // State C
                    if (in) state <= 2'b11; // Move to state D if in = 1
                    else state <= 2'b00; // Move to state A if in = 0
                end
                2'b11: begin // State D
                    if (in) state <= 2'b01; // Move to state B if in = 1
                    else state <= 2'b10; // Move to state C if in = 0
                end
            endcase
            if (state == 2'b11) out <= 1; // Output is 1 when state is D
            else out <= 0;
        end
    end

endmodule
