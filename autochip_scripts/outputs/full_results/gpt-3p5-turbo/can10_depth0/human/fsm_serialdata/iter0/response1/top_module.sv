module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    reg [7:0] received_byte;
    reg start_bit_detected;
    reg [2:0] state;
    wire stop_bit_expected;
    wire stop_bit_detected;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            received_byte <= 8'b0;
            start_bit_detected <= 1'b0;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    start_bit_detected <= in;
                    state <= 3'b001;
                end
                3'b001: begin // Waiting for start bit
                    if (start_bit_detected == 1'b0 && in == 1'b1) begin
                        state <= 3'b010;
                    end
                end
                3'b010: begin // Receiving data bits
                    received_byte <= {received_byte[6:0], in};
                    state <= 3'b011;
                end
                3'b011: begin // Waiting for stop bit
                    if (stop_bit_expected && in) begin
                        // Stop bit detected
                        state <= 3'b100;
                    end
                    if (stop_bit_expected == 0 && in == 1'b1) begin
                        // Start bit detected before stop bit
                        start_bit_detected <= 1'b1;
                        state <= 3'b001;
                    end
                end
                3'b100: begin // Byte received
                    state <= 3'b000;
                end
            endcase
        end
    end

    assign stop_bit_expected = received_byte[7];
    assign stop_bit_detected = (state == 3'b011 && in == 1'b1);

    assign out_byte = received_byte;
    assign done = (state == 3'b100);

endmodule
