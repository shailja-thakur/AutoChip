module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;
    reg start_bit_detected;
    reg [7:0] data;
    reg stop_bit_detected;
    reg done_reg;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            start_bit_detected <= 0;
            data <= 8'b0;
            stop_bit_detected <= 0;
            done_reg <= 0;
        end else begin
            case(state)
                3'b000: begin // Idle state
                    if (in == 1'b0) begin
                        state <= 3'b001; // Start bit detected
                    end
                end
                3'b001: begin // Start bit detected
                    if (in == 1'b1) begin
                        state <= 3'b010; // Start bit verified, go to data bits
                    end else begin
                        state <= 3'b000; // Invalid start bit, go back to idle
                    end
                end
                3'b010: begin // Receiving data bits
                    data <= {data[6:0], in}; // Shift in the received bit
                    state <= 3'b011;
                end
                3'b011: begin // Receiving data bits
                    data <= {data[6:0], in}; // Shift in the received bit
                    state <= 3'b100;
                end
                3'b100: begin // Receiving data bits
                    data <= {data[6:0], in}; // Shift in the received bit
                    state <= 3'b101;
                end
                3'b101: begin // Receiving data bits
                    data <= {data[6:0], in}; // Shift in the received bit
                    state <= 3'b110;
                end
                3'b110: begin // Receiving data bits
                    data <= {data[6:0], in}; // Shift in the received bit
                    state <= 3'b111;
                end
                3'b111: begin // Receiving data bits
                    data <= {data[6:0], in}; // Shift in the received bit
                    state <= 3'b000; // Go back to idle after 8 data bits
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            start_bit_detected <= 0;
            stop_bit_detected <= 0;
        end else begin
            case(state)
                3'b000: begin // Idle state
                    if (in == 1'b0) begin
                        start_bit_detected <= 1;
                    end else if (in == 1'b1) begin
                        start_bit_detected <= 0;
                    end
                end
                3'b001: begin // Start bit detected
                    start_bit_detected <= 0;
                end
                3'b010: begin // Start bit verified, go to data bits
                    // No action
                end
                3'b011: begin // Receiving data bits
                    // No action
                end
                3'b100: begin // Receiving data bits
                    // No action
                end
                3'b101: begin // Receiving data bits
                    // No action
                end
                3'b110: begin // Receiving data bits
                    // No action
                end
                3'b111: begin // Receiving data bits
                    // No action
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            stop_bit_detected <= 0;
        end else begin
            case(state)
                3'b000: begin // Idle state
                    if (in == 1'b1 && start_bit_detected) begin
                        stop_bit_detected <= 1;
                    end else if (in == 1'b0) begin
                        stop_bit_detected <= 0;
                    end
                end
                3'b001: begin // Start bit detected
                    stop_bit_detected <= 0;
                end
                3'b010: begin // Start bit verified, go to data bits
                    stop_bit_detected <= 0;
                end
                3'b011: begin // Receiving data bits
                    stop_bit_detected <= 0;
                end
                3'b100: begin // Receiving data bits
                    stop_bit_detected <= 0;
                end
                3'b101: begin // Receiving data bits
                    stop_bit_detected <= 0;
                end
                3'b110: begin // Receiving data bits
                    stop_bit_detected <= 0;
                end
                3'b111: begin // Receiving data bits
                    if (in == 1'b1) begin
                        stop_bit_detected <= 1;
                    end else if (in == 1'b0) begin
                        stop_bit_detected <= 0;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            done_reg <= 0;
        end else begin
            if (state == 3'b000 && stop_bit_detected) begin
                done_reg <= 1;
            end else begin
                done_reg <= 0;
            end
        end
    end

    assign done = done_reg;

endmodule
