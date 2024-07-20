module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // internal signals
    reg [1:0] next_state;
    
    always @(posedge clk or negedge areset) begin
        if (!areset) begin
            // reset state to 1
            state <= 2'b01;
        end else if (train_valid) begin
            case (state)
                2'b00: begin
                    if (train_taken) begin
                        // transition to next state
                        next_state <= 2'b01;
                    end else begin
                        // stay in current state
                        next_state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (train_taken) begin
                        // transition to next state
                        next_state <= 2'b10;
                    end else begin
                        if (state > 2'b00) begin
                            // transition to previous state
                            next_state <= 2'b00;
                        end else begin
                            // stay in current state
                            next_state <= 2'b01;
                        end
                    end
                end
                2'b10: begin
                    if (train_taken) begin
                        // transition to next state
                        next_state <= 2'b11;
                    end else begin
                        if (state > 2'b01) begin
                            // transition to previous state
                            next_state <= 2'b01;
                        end else begin
                            // stay in current state
                            next_state <= 2'b10;
                        end
                    end
                end
                2'b11: begin
                    if (!train_taken) begin
                        // transition to previous state
                        next_state <= 2'b10;
                    end else begin
                        // stay in current state
                        next_state <= 2'b11;
                    end
                end
                default: begin
                    // stay in current state
                    next_state <= state;
                end
            endcase
        end else begin
            // stay in current state
            next_state <= state;
        end
    end
    
    always @(posedge clk) begin
        state <= next_state;
    end
endmodule
