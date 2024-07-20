module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] data_byte;
reg stop_bit_detected;
reg [2:0] bit_counter;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        case (state)
            3'b000: begin // IDLE state
                if (in == 1'b0)
                    state <= 3'b001; // Start bit detected
                else
                    state <= 3'b000; // Stay in IDLE state
            end
            3'b001: begin // START state
                stop_bit_detected <= 1'b0; // Reset stop bit detected
                bit_counter <= 3'b000; // Reset bit counter
                data_byte <= 8'b00000000; // Clear data byte
                state <= 3'b010; // Go to RECEIVE state
            end
            3'b010: begin // RECEIVE state
                if (bit_counter < 3'b100) begin
                    data_byte[bit_counter] <= in; // Store data bit
                    bit_counter <= bit_counter + 1; // Increment bit counter
                end
                else if (bit_counter == 3'b100) begin
                    if (in == 1'b1) begin
                        stop_bit_detected <= 1'b1; // Stop bit detected
                        state <= 3'b011; // Go to VERIFY_STOP state
                    end
                    else
                        state <= 3'b000; // Return to IDLE state if stop bit is not 1
                end
            end
            3'b011: begin // VERIFY_STOP state
                if (in == 1'b1) begin
                    done <= 1'b1; // Assert done signal
                    out_byte <= data_byte; // Output received byte
                    state <= 3'b000; // Go back to IDLE state
                end
                else
                    state <= 3'b000; // Return to IDLE state if stop bit is not 1
            end
        endcase
    end
endmodule
