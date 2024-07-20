module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b10;  // B state
    else begin
        case (state)
            2'b00: begin  // A state
                if (in)
                    state <= 2'b00;  // Stay in A state
                else
                    state <= 2'b10;  // Transition to B state
            end
            2'b10: begin  // B state
                if (in)
                    state <= 2'b10;  // Stay in B state
                else
                    state <= 2'b00;  // Transition to A state
            end
        endcase
    end
end

always @(state) begin
    case (state)
        2'b00: out = 1;  // A state, set output to 0
        2'b10: out = 0;  // B state, set output to 1
    endcase
end

endmodule
