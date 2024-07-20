module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    reg [2:0] state;
    reg [7:0] data_byte;
    reg [2:0] bit_count;
    reg start_detected;
    reg stop_detected;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b0;
            data_byte <= 8'b0;
            bit_count <= 3'b0;
            start_detected <= 1'b0;
            stop_detected <= 1'b0;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    if (in == 1'b0) begin
                        state <= 3'b001;
                        start_detected <= 1'b1;
                        bit_count <= 3'b1;
                        data_byte <= in;
                    end
                end
                3'b001: begin // Receiving data bits
                    if (bit_count < 3'b100) begin
                        bit_count <= bit_count + 1;
                        data_byte[bit_count - 1] <= in;
                    end else if (bit_count == 3'b100) begin
                        state <= 3'b010;
                    end
                end
                3'b010: begin // Verifying stop bit
                    if (in == 1'b1) begin
                        stop_detected <= 1'b1;
                        state <= 3'b011;
                        done <= 1'b1;
                    end else begin
                        state <= 3'b000;
                        start_detected <= 1'b0;
                        bit_count <= 3'b0;
                    end
                end
                3'b011: begin // Wait for next start bit
                    if (in == 1'b0) begin
                        state <= 3'b001;
                        start_detected <= 1'b1;
                        bit_count <= 3'b1;
                        data_byte <= in;
                    end
                end
                default: begin
                    state <= 3'b000;
                    start_detected <= 1'b0;
                    bit_count <= 3'b0;
                end
            endcase
        end
    end

    assign out_byte = data_byte;
    assign done = stop_detected;

endmodule
