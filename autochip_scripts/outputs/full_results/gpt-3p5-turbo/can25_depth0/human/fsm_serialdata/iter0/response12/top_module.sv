module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] data_byte;
reg [7:0] received_byte;
reg start_bit_detected;
reg stop_bit_detected;
reg [3:0] bit_count;

assign out_byte = data_byte;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
        start_bit_detected <= 0;
        stop_bit_detected <= 0;
        bit_count <= 0;
        data_byte <= 0;
        received_byte <= 0;
        done <= 0;
    end else begin
        case (state)
            3'b000: begin // IDLE state
                if (in == 1'b0) begin
                    state <= 3'b001;
                    start_bit_detected <= 1;
                    bit_count <= 1;
                    received_byte <= 1;
                    data_byte <= 0;
                end
            end
            3'b001: begin // RECEIVING state
                if (bit_count < 8) begin
                    state <= 3'b001;
                    bit_count <= bit_count + 1;
                    received_byte <= received_byte << 1;
                    received_byte[0] <= in;
                end else begin
                    state <= 3'b010;
                    bit_count <= 1;
                    received_byte <= received_byte << 1;
                    received_byte[0] <= in;
                    data_byte <= received_byte;
                end
            end
            3'b010: begin // STOP_BIT state
                if (bit_count < 1) begin
                    if (in == 1'b1) begin
                        state <= 3'b011;
                        stop_bit_detected <= 1;
                        done <= 1;
                    end else begin
                        state <= 3'b000;
                    end
                end
            end
            3'b011: begin // DONE state
                if (in == 1'b1) begin
                    state <= 3'b000;
                end
            end
        endcase
    end
end

endmodule
