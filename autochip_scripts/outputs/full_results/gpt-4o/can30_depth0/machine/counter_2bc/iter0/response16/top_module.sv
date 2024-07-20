module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Declaration of state register
    logic [1:0] next_state;
    
    // State transition logic
    always_comb begin
        if (areset) begin
            next_state = 2'b01; // state 1
        end else if (train_valid) begin
            case (state)
                2'b00: next_state = (train_taken) ? 2'b01 : 2'b00;
                2'b01: next_state = (train_taken) ? 2'b10 : 2'b00;
                2'b02: next_state = (train_taken) ? 2'b11 : 2'b01;
                2'b03: next_state = (train_taken) ? 2'b11 : 2'b10;
                default: next_state = 2'b01; // state 1 as default
            endcase
        end else begin
            next_state = state;
        end
    end

    // State register update on clock edge
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // state 1
        end else begin
            state <= next_state;
        end
    end

endmodule
