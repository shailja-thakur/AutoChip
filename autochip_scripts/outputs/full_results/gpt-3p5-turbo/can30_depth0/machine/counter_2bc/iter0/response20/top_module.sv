module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1;
        else if (train_valid) begin
            case (state)
                0: begin
                    if (train_taken)
                        next_state <= 1;
                    else
                        next_state <= 0;
                end
                1: begin
                    if (train_taken)
                        next_state <= 2;
                    else
                        next_state <= 0;
                end
                2: begin
                    if (train_taken)
                        next_state <= 3;
                    else
                        next_state <= 1;
                end
                3: begin
                    if (train_taken)
                        next_state <= 3;
                    else
                        next_state <= 2;
                end
                default: next_state <= 1;
            endcase
        end else
            next_state <= state;
    end
    
    always @(posedge clk) begin
        state <= next_state;
    end

endmodule
