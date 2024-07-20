module top_module(
    input clk,
    input reset,
    output data_out,
    output valid_out
);

reg [1:0] state;
reg [7:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Idle state
        counter <= 8'd0;
        data_out <= 1'b0;
    end
    else begin
        case (state)
            2'b00: // Idle state
                begin
                    counter <= 8'd0;
                    data_out <= 1'b0;
                    state <= 2'b01; // Transition to Wait state
                end
            2'b01: // Wait state
                begin
                    counter <= counter + 8'd1;
                    data_out <= 1'b0;
                    if (counter == 8'd255) // Threshold reached
                        state <= 2'b10; // Transition to Process state
                end
            2'b10: // Process state
                begin
                    data_out <= 1'b1; // Set data output
                    state <= 2'b11; // Transition to Done state
                end
            2'b11: // Done state
                begin
                    valid_out <= 1'b1; // Assert valid output
                    state <= 2'b00; // Transition back to Idle state
                end
            default:
                begin
                    state <= 2'b00; // Default to Idle state
                end
        endcase
    end
end

endmodule
