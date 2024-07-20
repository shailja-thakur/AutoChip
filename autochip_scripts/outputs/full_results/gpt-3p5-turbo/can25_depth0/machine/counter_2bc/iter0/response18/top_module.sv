module top_module(
    input           clk,
    input           areset,
    input           train_valid,
    input           train_taken,
    output logic [1:0] state
);

    // Define states
    localparam [1:0] STATE_0 = 2'b00;
    localparam [1:0] STATE_1 = 2'b01;
    localparam [1:0] STATE_2 = 2'b10;
    localparam [1:0] STATE_3 = 2'b11;

    // Variable to hold the current state
    logic [1:0] current_state;

    // Asynchronous reset
    always_ff @(posedge clk or negedge areset)
    begin
        if (areset == 0)
            current_state <= STATE_1;
        else
            current_state <= current_state;
    end

    // State transition logic
    always @(posedge clk)
    begin
        case (current_state)
            STATE_0:
                if (train_valid && train_taken)
                    current_state <= STATE_1;
            STATE_1:
                if (train_valid && train_taken && (current_state < STATE_3))
                    current_state <= current_state + 1;
                else if (train_valid && !train_taken && (current_state > STATE_0))
                    current_state <= current_state - 1;
            STATE_2:
                if (train_valid && train_taken && (current_state < STATE_3))
                    current_state <= current_state + 1;
                else if (train_valid && !train_taken && (current_state > STATE_0))
                    current_state <= current_state - 1;
            STATE_3:
                if (train_valid && !train_taken && (current_state > STATE_0))
                    current_state <= current_state - 1;
        endcase
    end

    // Output assignment
    always_comb
    begin
        state <= current_state;
    end

endmodule
