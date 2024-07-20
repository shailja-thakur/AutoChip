module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output wire out
);

    // State declaration
    reg [1:0] state_reg, state_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state_reg <= 2'b00; // Initializing state A
        end else begin
            state_reg <= state_next; // Updating state
        end
    end

    always @(*) begin
        case (state_reg)
            2'b00: begin // State A
                if (j) begin
                    state_next = 2'b01; // Next state: B
                end else begin
                    state_next = 2'b00; // Next state: A
                end
                out = 1'b0; // Output: low
            end
            2'b01: begin // State B
                if (k) begin
                    state_next = 2'b00; // Next state: A
                end else begin
                    state_next = 2'b01; // Next state: B
                end
                out = 1'b1; // Output: high
            end
        endcase
    end

endmodule
