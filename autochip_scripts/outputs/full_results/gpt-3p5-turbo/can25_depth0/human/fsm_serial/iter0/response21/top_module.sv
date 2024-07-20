module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;
    reg [7:0] data;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b0;
            data <= 8'b0;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    if (in == 1'b0) begin
                        state <= 3'b001; // Start bit detected, move to next state
                        data <= 8'b0;
                    end
                end
                3'b001: begin // Receiving data bits
                    data <= {data[6:0], in}; // Shift in the received data bit
                    state <= 3'b010; // Move to next state
                end
                3'b010: begin // Waiting for all data bits to be received
                    state <= 3'b011; // Move to next state
                end
                3'b011: begin // Receiving stop bit
                    if (in == 1'b1) begin
                        state <= 3'b100; // Stop bit detected, move to next state
                    end
                end
                3'b100: begin // Byte received
                    state <= 3'b000; // Move back to idle state
                    done <= 1'b1; // Set done signal
                end
                default: begin
                    state <= 3'b0; // Reset state if undefined state is reached
                    data <= 8'b0; // Reset data
                end
            endcase
        end
    end

endmodule
