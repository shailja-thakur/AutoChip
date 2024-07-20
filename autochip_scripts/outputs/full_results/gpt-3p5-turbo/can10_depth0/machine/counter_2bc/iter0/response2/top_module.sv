module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define state variables
    logic [1:0] next_state;
    
    // Define state parameters
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;
    
    always_ff @(posedge clk or negedge areset) begin
        if (areset) begin
            state <= STATE_1;
        end else begin
            case (state)
                STATE_0: begin
                    if (train_valid && train_taken) begin
                        next_state = STATE_1;
                    end else begin
                        next_state = STATE_0;
                    end
                end
                STATE_1: begin
                    if (train_valid && train_taken && (state < STATE_3)) begin
                        next_state = state + 1;
                    end else if (train_valid && !train_taken && (state > STATE_0)) begin
                        next_state = state - 1;
                    end else begin
                        next_state = state;
                    end
                end
                STATE_2: begin
                    // Add logic for state 2 transitions
                end
                STATE_3: begin
                    // Add logic for state 3 transitions
                end
                default: begin
                    next_state = STATE_0;
                end
            endcase
            state <= next_state;
        end
    end
endmodule
