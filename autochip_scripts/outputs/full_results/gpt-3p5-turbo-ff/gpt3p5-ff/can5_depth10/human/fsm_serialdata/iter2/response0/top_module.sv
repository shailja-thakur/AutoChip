module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    reg [7:0] received_data;
    reg [3:0] bit_count;
    reg [2:0] state;
    reg [2:0] next_state;
    reg start_bit_detected;
    reg stop_bit_detected;

    // Internal signals
    wire start_bit = (bit_count == 0) ? 1'b0 : 1'b1;
    wire stop_bit = (bit_count == 9) ? 1'b1 : 1'b0;

    // Output signals
    assign out_byte = received_data;
    assign done = stop_bit_detected;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            received_data <= 8'b0;
            bit_count <= 4'b0;
            state <= 3'b000;
            start_bit_detected <= 1'b0;
            stop_bit_detected <= 1'b0;
        end else begin
            received_data <= (state == 3'b001) ? {received_data[6:0], in} : received_data;
            bit_count <= (state == 3'b001) ? bit_count + 1 : bit_count;
        end
    end

    always @* begin
        case (state)
            3'b000: begin // Idle state
                next_state = (start_bit_detected) ? 3'b001 : 3'b000;
                stop_bit_detected = 1'b0;
            end
            3'b001: begin // Receiving data bits
                next_state = (bit_count == 8) ? 3'b010 : 3'b001;
                start_bit_detected = 1'b0;
            end
            3'b010: begin // Waiting for stop bit
                next_state = (stop_bit_detected) ? 3'b000 : 3'b010;
                stop_bit_detected = stop_bit;
            end
            default: next_state = 3'b000;
        endcase
    end
endmodule
