module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 2'd1;
        end
        else if (train_valid) begin
            case (state)
                2'd0: begin
                    if (train_taken) begin
                        state <= 2'd1;
                    end
                    else begin
                        state <= 2'd0;
                    end
                end
                2'd1: begin
                    if (train_taken) begin
                        state <= 2'd2;
                    end
                    else begin
                        state <= 2'd0;
                    end
                end
                2'd2: begin
                    if (train_taken) begin
                        state <= 2'd3;
                    end
                    else begin
                        state <= 2'd1;
                    end
                end
                2'd3: begin
                    if (train_taken) begin
                        state <= 2'd3;
                    end
                    else begin
                        state <= 2'd2;
                    end
                end
                default: begin
                    state <= 2'd1;
                end
            endcase
        end
        else begin
            state <= state;
        end
    end

endmodule
