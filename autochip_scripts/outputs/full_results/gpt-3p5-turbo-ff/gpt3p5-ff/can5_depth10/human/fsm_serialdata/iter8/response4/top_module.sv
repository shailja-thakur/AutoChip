module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    reg [7:0] received_data;
    reg [2:0] state;
    reg [2:0] next_state;
    reg start_bit_detected;

    // Internal signals
    wire stop_bit_detected = (state == 3'b010) ? 1'b1 : 1'b0;

    // Output signals
    assign out_byte = received_data;
    assign done = stop_bit_detected;

    always @(posedge clk) begin
        if (reset) begin
            received_data <= 8'b0;
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    start_bit_detected <= in;
                    state <= (start_bit_detected) ? 3'b001 : 3'b000;
                end
                3'b001: begin // Receiving data bits
                    received_data <= {received_data[6:0], in};
                    if (state[2:0] == 3'b111) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b010: begin // Waiting for stop bit
                    state <= (stop_bit_detected) ? 3'b000 : 3'b010;
                end
                default: state <= 3'b000;
            endcase
        end
    end
endmodule
