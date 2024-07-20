module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = (in) ? 2'b01 : 2'b00; // A, B
            out = 1'b0;
        end
        2'b01: begin // State B
            next_state = (in) ? 2'b01 : 2'b10; // B, C
            out = 1'b0;
        end
        2'b10: begin // State C
            next_state = (in) ? 2'b11 : 2'b00; // D, A
            out = 1'b0;
        end
        2'b11: begin // State D
            next_state = (in) ? 2'b01 : 2'b10; // B, C
            out = 1'b1;
        end
    endcase
end

// State register
always @(posedge clk) begin
    if (reset)
        state <= 2'b00; // Reset to state A
    else
        state <= next_state;
end

endmodule
