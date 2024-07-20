module top_module(
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output logic [1:0] state
);
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1;
        end else begin
            case (state)
                0: begin
                    if (train_taken && state < 3) begin
                        next_state <= state + 1;
                    end else if (!train_taken && state > 0) begin
                        next_state <= state - 1;
                    end else begin
                        next_state <= state;
                    end
                end
                1: begin
                    if (train_valid) begin
                        next_state <= 0;
                    end else begin
                        next_state <= 1;
                    end
                end
                2: begin
                    if (train_taken && state < 3) begin
                        next_state <= state + 1;
                    end else if (!train_taken && state > 0) begin
                        next_state <= state - 1;
                    end else begin
                        next_state <= state;
                    end
                end
                3: begin
                    if (train_taken) begin
                        next_state <= 3;
                    end else begin
                        next_state <= state;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        state <= next_state;
    end
endmodule
