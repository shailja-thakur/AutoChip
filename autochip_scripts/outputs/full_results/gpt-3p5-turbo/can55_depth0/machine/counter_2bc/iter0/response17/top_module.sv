module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// Define states
localparam IDLE = 2'b00;
localparam STATE_1 = 2'b01;
localparam STATE_2 = 2'b10;
localparam STATE_3 = 2'b11;

// Registers for state and next state
reg [1:0] current_state;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset, go to state 1
        current_state <= STATE_1;
    end else begin
        // Check if valid signal is asserted
        if (train_valid) begin
            // Check if taken signal is asserted
            if (train_taken) begin
                // Transition to next state if current state is less than 3
                if (current_state < STATE_3) begin
                    next_state <= current_state + 1;
                end else begin
                    next_state <= current_state;
                end
            end else begin
                // Transition to previous state if current state is greater than 0
                if (current_state > STATE_1) begin
                    next_state <= current_state - 1;
                end else begin
                    next_state <= current_state;
                end
            end
        end else begin
            // No valid signal, stay in current state
            next_state <= current_state;
        end
    end
end

// Update current state with next state
always @(posedge clk) begin
    current_state <= next_state;
end

// Assign the state output
assign state = current_state;

endmodule
