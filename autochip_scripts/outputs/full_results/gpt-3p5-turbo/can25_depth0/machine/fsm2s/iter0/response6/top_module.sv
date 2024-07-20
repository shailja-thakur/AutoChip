module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state;
    reg [1:0] next_state;

    // Initial state
    initial begin
        state = 2'b00; // State A
        out = 1'b0;    // Initialize output
    end

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // State A
        end else begin
            case (state)
                2'b00: begin // State A
                    if (j) begin
                        next_state = 2'b01; // Next state B
                    end else begin
                        next_state = 2'b00; // Next state A
                    end
                end
                2'b01: begin // State B
                    if (k) begin
                        next_state = 2'b00; // Next state A
                    end else begin
                        next_state = 2'b01; // Next state B
                    end
                end
            endcase
            state <= next_state;
        end
    end

    // Output assignment
    always @(state) begin
        if (state == 2'b01) begin
            out <= 1'b1; // State B
        end else begin
            out <= 1'b0; // State A
        end
    end

endmodule
