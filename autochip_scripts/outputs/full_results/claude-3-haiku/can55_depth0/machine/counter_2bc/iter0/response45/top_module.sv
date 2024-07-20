module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    localparam [1:0] 
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11;

    // Initialize the state to S1 on reset
    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= S1;
        end
        else if (train_valid) begin
            case (state)
                S0: begin
                    if (train_taken) begin
                        state <= S1;
                    end
                    else begin
                        state <= S0;
                    end
                end
                S1: begin
                    if (train_taken) begin
                        state <= S2;
                    end
                    else begin
                        state <= S0;
                    end
                end
                S2: begin
                    if (train_taken) begin
                        state <= S3;
                    end
                    else begin
                        state <= S1;
                    end
                end
                S3: begin
                    if (train_taken) begin
                        state <= S3;
                    end
                    else begin
                        state <= S2;
                    end
                end
                default: begin
                    state <= S1;
                end
            endcase
        end
    end

endmodule
