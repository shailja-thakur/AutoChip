module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define states
parameter [1:0] idle = 2'b00;
parameter [1:0] state_left = 2'b01;
parameter [1:0] state_right = 2'b10;

// Define current state
reg [1:0] current_state;

// Define next state
reg [1:0] next_state;

// Define output
reg output;

// Always block to update the state and output
always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset to initial state
        current_state <= idle;
    end else begin
        // Update the current state based on the next state
        current_state <= next_state;
    end
end

// Declare the output register as combinational
always @(current_state, bump_left, bump_right) begin
    // Default output is 1'b0
    output = 1'b0;
    
    // Update the next state based on the current state and inputs
    case (current_state)
        idle: begin
            if (bump_left && bump_right) begin
                next_state = state_left;
                output = 1'b1;
            end else if (bump_left) begin
                next_state = state_right;
                output = 1'b0;
            end else if (bump_right) begin
                next_state = state_left;
                output = 1'b1;
            end else begin
                next_state = idle;
                output = 1'b0;
            end
        end
        state_left: begin
            if (bump_left) begin
                next_state = state_right;
                output = 1'b0;
            end else begin
                next_state = state_left;
                output = 1'b1;
            end
        end
        state_right: begin
            if (bump_right) begin
                next_state = state_left;
                output = 1'b1;
            end else begin
                next_state = state_right;
                output = 1'b0;
            end
        end
        default: begin
            next_state = idle;
            output = 1'b0;
        end
    endcase
end

// Assign the output values
assign walk_left = output;
assign walk_right = ~output;

endmodule
