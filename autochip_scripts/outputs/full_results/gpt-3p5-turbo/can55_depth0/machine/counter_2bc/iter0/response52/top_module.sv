module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Declare the states
    localparam [1:0] STATE_0 = 2'b00;
    localparam [1:0] STATE_1 = 2'b01;
    localparam [1:0] STATE_2 = 2'b10;
    localparam [1:0] STATE_3 = 2'b11;

    // Declare the current state
    reg [1:0] current_state;

    // Synchronous reset
    always @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            current_state <= STATE_1;
        end else begin
            if (train_valid == 1) begin
                if (train_taken == 1 && current_state < STATE_3) begin
                    current_state <= current_state + 1;
                end else if (train_taken == 0 && current_state > STATE_0) begin
                    current_state <= current_state - 1;
                end
            end
        end
    end

    // Assign the output state based on the current state
    always @(current_state) begin
        case (current_state)
            STATE_0: state <= STATE_0;
            STATE_1: state <= STATE_1;
            STATE_2: state <= STATE_2;
            STATE_3: state <= STATE_3;
        endcase
    end
endmodule
