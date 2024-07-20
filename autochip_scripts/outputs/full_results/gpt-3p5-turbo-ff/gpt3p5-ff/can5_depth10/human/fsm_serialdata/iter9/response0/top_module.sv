module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    reg [2:0] state;
    reg [7:0] received_data;
    reg start_bit_detected;
    reg stop_bit_detected;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            received_data <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    start_bit_detected <= (in == 1'b0);
                    state <= (start_bit_detected) ? 3'b001 : 3'b000;
                end
                3'b001: begin // Receiving data bits
                    received_data <= {received_data[6:0], in};
                    state <= (state == 3'b111) ? 3'b010 : 3'b001;
                end
                3'b010: begin // Waiting for stop bit
                    stop_bit_detected <= (in == 1'b1);
                    state <= (stop_bit_detected) ? 3'b100 : 3'b010;
                end
                3'b100: begin // Done state
                    out_byte <= received_data;
                    done <= 1'b1;
                    state <= (in == 1'b1) ? 3'b000 : 3'b100;
                end
            endcase
        end
    end
endmodule
