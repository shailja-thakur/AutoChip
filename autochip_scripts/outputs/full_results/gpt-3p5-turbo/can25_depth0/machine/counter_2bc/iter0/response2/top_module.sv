module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State definitions
    parameter STATE_0 = 2'b00;
    parameter STATE_1 = 2'b01;
    parameter STATE_2 = 2'b10;
    parameter STATE_3 = 2'b11;

    // Declare internal signals
    reg [1:0] next_state;

    // State machine logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state 1
            state <= STATE_1;
        end else begin
            if (train_valid) begin
                // Transition based on train_taken
                case (state)
                    STATE_0: begin
                        if (train_taken) begin
                            next_state <= STATE_1;
                        end else begin
                            next_state <= STATE_0;
                        end
                    end
                    STATE_1: begin
                        if (train_taken) begin
                            next_state <= STATE_2;
                        end else begin
                            next_state <= STATE_0;
                        end
                    end
                    STATE_2: begin
                        if (train_taken) begin
                            next_state <= STATE_3;
                        end else begin
                            next_state <= STATE_1;
                        end
                    end
                    STATE_3: begin
                        if (train_taken) begin
                            next_state <= STATE_3;
                        end else begin
                            next_state <= STATE_2;
                        end
                    end
                endcase
            end else begin
                // Stay in current state if train_valid is not asserted
                next_state <= state;
            end
            state <= next_state;
        end
    end

endmodule
