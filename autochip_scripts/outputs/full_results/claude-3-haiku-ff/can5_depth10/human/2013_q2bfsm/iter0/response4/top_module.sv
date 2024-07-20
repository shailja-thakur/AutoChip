module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

// Define the states of the finite state machine
localparam STATE_A = 2'd0; // Reset/Beginning state
localparam STATE_B = 2'd1; // Set f to 1 for one clock cycle
localparam STATE_C = 2'd2; // Monitor x input and set g to 1 if x is 1, 0, 1
localparam STATE_D = 2'd3; // Monitor y input and maintain g = 1 or set g = 0 permanently

// Register to store the current state
reg [1:0] state;

// Register to store the previous two values of x
reg [1:0] x_history;

// Register to track the number of clock cycles since y was 1
reg [1:0] y_count;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        // Reset the FSM to the beginning state
        state <= STATE_A;
        f <= 0;
        g <= 0;
        x_history <= 0;
        y_count <= 0;
    end
    else begin
        case (state)
            STATE_A: begin
                // Stay in this state until reset is de-asserted
                if (resetn) begin
                    state <= STATE_B;
                    f <= 1; // Set f to 1 for one clock cycle
                end
            end
            STATE_B: begin
                // After one clock cycle, move to the next state
                state <= STATE_C;
                f <= 0; // Clear f
            end
            STATE_C: begin
                // Monitor the x input and set g to 1 if x is 1, 0, 1
                x_history <= {x_history[0], x};
                if (x_history == 2'b101) begin
                    g <= 1;
                    state <= STATE_D;
                end
            end
            STATE_D: begin
                // Monitor the y input and maintain g = 1 or set g = 0 permanently
                if (y) begin
                    y_count <= 0;
                end
                else begin
                    y_count <= y_count + 1;
                end
                if (y_count == 2) begin
                    g <= 0;
                end
            end
        endcase
    end
end

endmodule
