module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            next_state <= 2'b01; // reset to state 1
        end else begin
            case (state)
                2'b00: begin
                    if (train_taken && state < 2'b11) begin
                        next_state <= state + 1; // transition to next state
                    end else begin
                        next_state <= state; // stay in current state
                    end
                end
                2'b01: begin
                    if (train_valid && train_taken && state < 2'b11) begin
                        next_state <= state + 1; // transition to next state
                    end else begin
                        next_state <= state; // stay in current state
                    end
                end
                2'b10: begin
                    if (!train_taken && state > 2'b00) begin
                        next_state <= state - 1; // transition to previous state
                    end else begin
                        next_state <= state; // stay in current state
                    end
                end
                2'b11: begin
                    if (train_taken && state < 2'b11) begin
                        next_state <= state + 1; // transition to next state
                    end else if (!train_taken && state > 2'b00) begin
                        next_state <= state - 1; // transition to previous state
                    end else begin
                        next_state <= state; // stay in current state
                    end
                end
                default: begin
                    next_state <= state; // stay in current state
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        state <= next_state;
    end
endmodule
