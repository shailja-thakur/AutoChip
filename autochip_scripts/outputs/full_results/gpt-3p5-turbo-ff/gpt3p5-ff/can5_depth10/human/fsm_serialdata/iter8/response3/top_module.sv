module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    reg [7:0] received_data;
    reg [2:0] state;
    reg [7:0] shift_register;
    reg start_bit_detected;

    // Internal signals
    wire stop_bit_detected = (shift_register == 8'd255) ? 1'b1 : 1'b0;

    // Output signals
    assign out_byte = received_data;
    assign done = stop_bit_detected;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            received_data <= 8'b0;
            shift_register <= 8'b0;
            state <= 3'b000;
            start_bit_detected <= 1'b0;
        end else begin
            start_bit_detected <= (in == 1'b0);
            shift_register <= {shift_register[6:0], in};
            case (state)
                3'b000: begin // Idle state
                    received_data <= 8'b0; // Reset received data
                    if (start_bit_detected) begin
                        state <= 3'b001; // Transition to receiving data bits
                    end
                end
                3'b001: begin // Receiving data bits
                    received_data <= {received_data[6:0], in}; // Shift in received data
                    if (shift_register == 8'd255) begin
                        state <= 3'b010; // Transition to waiting for stop bit
                    end
                end
                3'b010: begin // Waiting for stop bit
                    if (stop_bit_detected) begin
                        state <= 3'b000; // Transition to idle state
                    end
                end
                default: state <= 3'b000; // Reset to idle state if in an unknown state
            endcase
        end
    end
endmodule
