module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// State definition
typedef enum logic [1:0] {
    IDLE,
    PROCESSING
} state_t;

// Signal declaration
reg          areset_n;      // Negative active reset
reg          reset_n;       // Negative active reset signal for the state machine
reg          reset_r;       // Reset signal delayed by one clock cycle
reg          reset_triggered;   // Flag indicating if reset is triggered
reg          x_reg;         // Input register
reg [1:0]    state;         // State register

// Output assignment
assign z = ~x_reg;

// Negative active reset
assign areset_n = ~areset;
assign reset_n = ~reset_r;

// Reset synchronization
always @(posedge clk) begin
    reset_r <= reset_n;
end

// State machine
always @(posedge clk) begin
    if (areset_n) begin
        state <= IDLE;
        reset_triggered <= 0;
        x_reg <= 0;
    end else if (reset_triggered) begin
        state <= IDLE;
        x_reg <= 0;
    end else begin
        case (state)
            IDLE:
                if (!areset_n) begin
                    reset_triggered <= 1;
                end else if (x) begin
                    state <= PROCESSING;
                    x_reg <= x;
                end
            PROCESSING:
                state <= IDLE;
        endcase
    end
end

endmodule
