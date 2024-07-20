module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define states
    parameter [1:0] STATE_0 = 2'b00;
    parameter [1:0] STATE_1 = 2'b01;
    parameter [1:0] STATE_2 = 2'b10;
    parameter [1:0] STATE_3 = 2'b11;

    // State register
    reg [1:0] current_state, next_state;

    // Asynchronous reset or state transition
    always @(posedge clk or posedge areset) begin
        if (areset) 
            current_state <= STATE_1;
        else 
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        if (train_valid) begin
            case (current_state)
                STATE_0: next_state = (train_taken) ? STATE_1 : STATE_0;
                STATE_1: next_state = (train_taken) ? STATE_2 : STATE_0;
                STATE_2: next_state = (train_taken) ? STATE_3 : STATE_1;
                STATE_3: next_state = (train_taken) ? STATE_3 : STATE_2;
                default: next_state = STATE_1;
            endcase
        end else begin
            next_state = current_state;
        end
    end

    // Output state
    assign state = current_state;

endmodule
