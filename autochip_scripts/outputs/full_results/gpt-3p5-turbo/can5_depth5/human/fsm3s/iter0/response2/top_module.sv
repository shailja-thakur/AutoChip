module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state, next_state;
reg out;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00; // Reset to state A
    else
        state <= next_state;
end

always @(state, in) begin
    case (state)
        2'b00: begin // State A
            if (in)
                next_state = 2'b01; // Next state in=1, B
            else
                next_state = 2'b00; // Next state in=0, A
            out = 1'b0;
        end
        2'b01: begin // State B
            if (in)
                next_state = 2'b01; // Next state in=1, B
            else
                next_state = 2'b10; // Next state in=0, C
            out = 1'b0;
        end
        2'b10: begin // State C
            if (in)
                next_state = 2'b11; // Next state in=1, D
            else
                next_state = 2'b00; // Next state in=0, A
            out = 1'b0;
        end
        2'b11: begin // State D
            if (in)
                next_state = 2'b01; // Next state in=1, B
            else
                next_state = 2'b10; // Next state in=0, C
            out = 1'b1;
        end
    endcase
end

assign out = out;

endmodule
