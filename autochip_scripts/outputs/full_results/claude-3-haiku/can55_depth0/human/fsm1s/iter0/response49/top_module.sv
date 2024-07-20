module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
localparam STATE_B = 1'b0; // reset state
localparam STATE_A = 1'b1;

// Define the state register
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_B;
    end
    else begin
        case (state)
            STATE_B: begin // B state
                out <= 1'b1; // set output to 1
                if (in) begin
                    state <= STATE_B; // stay in B state on in=1
                end
                else begin
                    state <= STATE_A; // transition to A state on in=0
                end
            end
            STATE_A: begin // A state
                out <= 1'b0; // set output to 0
                if (in) begin
                    state <= STATE_A; // stay in A state on in=1
                end
                else begin
                    state <= STATE_B; // transition to B state on in=0
                end
            end
            default: begin
                state <= STATE_B; // default to B state
            end
        endcase
    end
end

endmodule
