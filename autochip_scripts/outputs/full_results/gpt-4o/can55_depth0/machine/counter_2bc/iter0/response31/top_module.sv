module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// Define states as local parameters for readability
localparam STATE_0 = 2'b00;
localparam STATE_1 = 2'b01;
localparam STATE_2 = 2'b10;
localparam STATE_3 = 2'b11;

logic [1:0] current_state, next_state;

// State transition logic (combinational)
always_comb begin
    case (current_state)
        STATE_0: begin
            if (train_valid && train_taken)
                next_state = STATE_1;
            else
                next_state = STATE_0;
        end
        
        STATE_1: begin
            if (train_valid && train_taken)
                next_state = STATE_2;
            else if (train_valid && !train_taken)
                next_state = STATE_0;
            else
                next_state = STATE_1;
        end
        
        STATE_2: begin
            if (train_valid && train_taken)
                next_state = STATE_3;
            else if (train_valid && !train_taken)
                next_state = STATE_1;
            else
                next_state = STATE_2;
        end
        
        STATE_3: begin
            if (train_valid && !train_taken)
                next_state = STATE_2;
            else
                next_state = STATE_3;
        end

        default: next_state = STATE_1;  // Default state
    endcase
end

// State register (sequential)
always_ff @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= STATE_1;  // Reset to state 1
    else
        current_state <= next_state;
end

// Output current state
assign state = current_state;

endmodule
