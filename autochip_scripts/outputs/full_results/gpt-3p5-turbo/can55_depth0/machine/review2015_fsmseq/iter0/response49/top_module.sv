module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting
);

    reg [1:0] state;
    reg start_shifting_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Initialize state to S
            start_shifting_reg <= 1'b0;
        end else begin
            case (state)
                2'b00: begin // S
                    if (data) begin
                        state <= 2'b01; // Transition to S1
                        start_shifting_reg <= 1'b0;
                    end
                end
                2'b01: begin // S1
                    if (data) begin
                        state <= 2'b10; // Transition to S11
                        start_shifting_reg <= 1'b0;
                    end else begin
                        state <= 2'b00; // Transition back to S
                    end
                end
                2'b10: begin // S11
                    if (data) begin
                        state <= 2'b10; // Stay in S11
                        start_shifting_reg <= 1'b0;
                    end else begin
                        state <= 2'b11; // Transition to S110
                    end
                end
                2'b11: begin // S110
                    if (data) begin
                        state <= 2'b11; // Stay in S110
                        start_shifting_reg <= 1'b1; // Output is high
                    end else begin
                        state <= 2'b00; // Transition back to S
                    end
                end
                default: begin
                    state <= 2'b00; // Reset to S
                    start_shifting_reg <= 1'b0;
                end
            endcase
        end
    end
    
    assign start_shifting = start_shifting_reg;
    
endmodule
