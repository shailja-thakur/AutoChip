module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [1:0] state;
    reg start_shifting;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            start_shifting <= 0;
        end else begin
            case (state)
                2'b00: begin // Idle state
                    if (data) begin
                        state <= 2'b01; // Check for the first '1'
                    end
                end
                2'b01: begin // Found the first '1'
                    if (data) begin
                        state <= 2'b10; // Check for '10'
                    end else begin
                        state <= 2'b00; // Go back to idle state
                    end
                end
                2'b10: begin // Found '10'
                    if (data) begin
                        state <= 2'b11; // Check for '110'
                    end else begin
                        state <= 2'b00; // Go back to idle state
                    end
                end
                2'b11: begin // Found '110'
                    if (data) begin
                        start_shifting <= 1; // Set start_shifting to 1
                        state <= 2'b11; // Stay in this state forever
                    end else begin
                        state <= 2'b00; // Go back to idle state
                    end
                end
            endcase
        end
    end

endmodule
