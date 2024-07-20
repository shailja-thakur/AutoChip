module top_module (
    input clk,
    input in,
    input reset,
    output out
);

// Define states for the state machine
typedef enum logic[1:0] {
    IDLE,
    STATE_A,
    STATE_B,
    STATE_C,
    STATE_D
} state_type;

// Define signals for the state machine
reg [1:0] current_state;
reg [1:0] next_state;
reg out_reg;

// State transition and output logic
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset the state machine to STATE_A
        current_state <= STATE_A;
        out_reg <= 0;
    end else begin
        // Update the current state based on the next state
        current_state <= next_state;
        out_reg <= (current_state == STATE_D) ? 1'b1 : 1'b0;
    end
end

// Combinational logic for next state calculation
always_comb begin
    case (current_state)
        STATE_A: begin
            if (in) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            if (in) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_C;
            end
        end
        STATE_C: begin
            if (in) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_D: begin
            if (in) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_C;
            end
        end
        default: next_state = STATE_A;
    endcase
end

// Assign output to the registered output signal
assign out = out_reg;

endmodule
