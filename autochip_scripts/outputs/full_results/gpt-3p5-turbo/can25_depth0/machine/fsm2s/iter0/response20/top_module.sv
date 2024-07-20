module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg state;  // State register to hold current state

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;  // Initialize state to A when reset is high
        end else begin
            if (state == 0) begin  // Current state is A
                if (j) begin
                    state <= 1;  // Next state is B if j is high
                end else begin
                    state <= 0;  // Next state remains A if j is low
                end
            end else begin  // Current state is B
                if (k) begin
                    state <= 0;  // Next state is A if k is high
                end else begin
                    state <= 1;  // Next state remains B if k is low
                end
            end
        end
    end

    always @(state) begin
        out <= state;  // Output is high when state is B, low otherwise
    end

endmodule
