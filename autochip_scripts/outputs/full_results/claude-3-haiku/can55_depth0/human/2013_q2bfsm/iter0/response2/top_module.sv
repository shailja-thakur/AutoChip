module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

// Define the states of the FSM
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

// Register to store the current state
reg [1:0] state;

// Register to store the previous two values of x
reg [1:0] x_history;

// Register to store the count of consecutive y = 1 inputs
reg [1:0] y_count;

// Update the state and outputs based on the inputs and current state
always @(posedge clk) begin
    if (!resetn) begin
        // Reset the FSM to the beginning state
        state <= STATE_A;
        f <= 0;
        g <= 0;
        x_history <= 0;
        y_count <= 0;
    end else begin
        case (state)
            STATE_A: begin
                // Stay in state A until resetn is de-asserted
                f <= 0;
                g <= 0;
                x_history <= {x_history[0], x};
                y_count <= 0;
                if (resetn) begin
                    state <= STATE_B;
                end
            end
            STATE_B: begin
                // Set f to 1 for one clock cycle
                f <= 1;
                g <= 0;
                x_history <= {x_history[0], x};
                y_count <= 0;
                state <= STATE_C;
            end
            STATE_C: begin
                // Monitor the x input for the sequence 1, 0, 1
                f <= 0;
                g <= 0;
                x_history <= {x_history[0], x};
                y_count <= 0;
                if (x_history == 2'b101) begin
                    state <= STATE_D;
                end
            end
            STATE_D: begin
                // Set g to 1 and monitor the y input
                f <= 0;
                g <= 1;
                x_history <= {x_history[0], x};
                if (y) begin
                    y_count <= 2'b10;
                end else begin
                    y_count <= y_count - 1'b1;
                end
                if (y_count == 0) begin
                    g <= 0;
                end
            end
        endcase
    end
end

endmodule
