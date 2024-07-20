module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state, next_state;

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = (in) ? 2'b01 : 2'b00; // Next state is B if in=1, else A
            out = 1'b0; // Output is 0
        end
        2'b01: begin // State B
            next_state = (in) ? 2'b01 : 2'b10; // Next state is B if in=1, else C
            out = 1'b0; // Output is 0
        end
        2'b10: begin // State C
            next_state = (in) ? 2'b11 : 2'b00; // Next state is D if in=1, else A
            out = 1'b0; // Output is 0
        end
        2'b11: begin // State D
            next_state = (in) ? 2'b01 : 2'b10; // Next state is B if in=1, else C
            out = 1'b1; // Output is 1
        end
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // Reset to state A
    end
    else begin
        state <= next_state;
    end
end

endmodule
