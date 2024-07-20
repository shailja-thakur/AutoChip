module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;
    reg [7:0] data;
    reg stop_bit_found;
    reg byte_received;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            data <= 8'b0;
            stop_bit_found <= 1'b0;
            byte_received <= 1'b0;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    if (in == 1'b0) begin
                        state <= 3'b001; // Wait for start bit
                    else
                        state <= 3'b000;
                    end
                end
                3'b001: begin // Wait for start bit
                    if (in == 1'b0) begin
                        state <= 3'b010; // Receive data bits
                        data <= 8'b0;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b010: begin // Receive data bits
                    data <= {data[6:0], in}; // Shift in received bit
                    if (stop_bit_found) begin
                        state <= 3'b011; // Verify stop bit
                    end
                end
                3'b011: begin // Verify stop bit
                    if (in == 1'b1) begin
                        if (data == 8'b0) begin
                            byte_received <= 1'b1; // Byte received successfully
                        end
                        state <= 3'b000;
                    end else begin
                        byte_received <= 1'b0; // Invalid stop bit, wait for next stop bit
                    end
                end
                default: state <= 3'b000;
            endcase
        end
    end

    assign done = byte_received;

endmodule
