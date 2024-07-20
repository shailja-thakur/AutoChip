module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

// Define the states of the FSM
parameter STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10, STATE_D = 2'b11;

// Register to hold the current state
reg [1:0] state, next_state;

// Register to store the sequence of x values
reg [1:0] x_seq;

// Register to count the number of clock cycles since y became 1
reg [1:0] y_count;

// Combinational logic to determine the next state and outputs
always @(*) begin
    // Default values for outputs
    f = 1'b0;
    g = 1'b0;

    case (state)
        STATE_A: begin
            // Reset state
            if (!resetn) begin
                next_state = STATE_A;
            end else begin
                // Move to the next state after one clock cycle
                next_state = STATE_B;
                f = 1'b1; // Set f to 1 for one clock cycle
            end
        end
        STATE_B: begin
            // Monitor the x input
            next_state = STATE_C;
            x_seq = {x_seq[0], x};
        end
        STATE_C: begin
            // Check the sequence of x values
            if (x_seq == 2'b101) begin
                next_state = STATE_D;
                g = 1'b1; // Set g to 1
            end else begin
                next_state = STATE_B;
            end
        end
        STATE_D: begin
            // Monitor the y input
            if (y) begin
                y_count = 2'b00;
            end else begin
                y_count = y_count + 1'b1;
            end

            // Maintain g = 1 if y becomes 1 within two clock cycles, otherwise set g = 0
            if (y_count == 2'b10) begin
                g = 1'b0;
            end
            next_state = STATE_D;
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

// Sequential logic to update the state
always @(posedge clk) begin
    if (!resetn) begin
        state <= STATE_A;
        x_seq <= 2'b00;
        y_count <= 2'b00;
    end else begin
        state <= next_state;
    end
end

endmodule
