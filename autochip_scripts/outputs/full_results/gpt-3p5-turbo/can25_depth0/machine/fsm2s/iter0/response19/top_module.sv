module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;  // Initialize state to A
        end else begin
            state <= next_state; // Update state based on next_state
        end
    end

    always @(state, j, k) begin
        case (state)
            2'b00: begin // state A
                if (j) begin // if j is high
                    next_state = 2'b01; // transition to state B
                end else begin
                    next_state = 2'b00; // stay in state A
                end
            end

            2'b01: begin // state B
                    if (k) begin // if k is high
                        next_state = 2'b00; // transition to state A
                    end else begin
                        next_state = 2'b01; // stay in state B
                    end
            end

            default: next_state = 2'b00; // Reset to state A
        endcase
    end

    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // out is high when state is B, low when state is A

endmodule
