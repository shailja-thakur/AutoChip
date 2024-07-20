module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state;
    reg next_state;

    // Synchronous Reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b0;  // Initialize with state B
        end
        else begin
            state <= next_state;  // Update state based on next_state value
        end
    end

    // Next state logic
    always @(state, in) begin
        case (state)
            2'b00: begin  // B state
                if (in) begin
                    next_state = 2'b00;  // Stay in B state
                end
                else begin
                    next_state = 2'b01;  // Move to A state
                end
            end

            2'b01: begin  // A state
                if (in) begin
                    next_state = 2'b01;  // Stay in A state
                end
                else begin
                    next_state = 2'b00;  // Move to B state
                end
            end
        endcase
    end

    // Output logic
    always @(state) begin
        case (state)
            2'b00: out = 1'b1;  // B state, out=1
            2'b01: out = 1'b0;  // A state, out=0
        endcase
    end

endmodule
