module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    parameter [1:0] STATE_0 = 2'b00;
    parameter [1:0] STATE_1 = 2'b01;
    parameter [1:0] STATE_2 = 2'b10;
    parameter [1:0] STATE_3 = 2'b11;

    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= STATE_1;
        end
        else if (train_valid) begin
            case (state)
                STATE_0: begin
                    if (train_taken) begin
                        state <= STATE_1;
                    end
                    else begin
                        state <= STATE_0;
                    end
                end
                STATE_1: begin
                    if (train_taken) begin
                        state <= STATE_2;
                    end
                    else begin
                        state <= STATE_0;
                    end
                end
                STATE_2: begin
                    if (train_taken) begin
                        state <= STATE_3;
                    end
                    else begin
                        state <= STATE_1;
                    end
                end
                STATE_3: begin
                    if (train_taken) begin
                        state <= STATE_3;
                    end
                    else begin
                        state <= STATE_2;
                    end
                end
                default: begin
                    state <= STATE_1;
                end
            endcase
        end
        else begin
            state <= state;
        end
    end

endmodule
