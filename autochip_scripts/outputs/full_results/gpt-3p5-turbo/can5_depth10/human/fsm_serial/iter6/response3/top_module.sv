module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define states
localparam IDLE = 2'b00;
localparam DETECT_START_BIT = 2'b01;
localparam RECEIVING_DATA = 2'b10;
localparam DETECT_STOP_BIT = 2'b11;

// Define signals
reg [1:0] state;
reg [7:0] received_data;
reg start_bit_detected;
reg stop_bit_detected;

// Synchronous reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        received_data <= 0;
        start_bit_detected <= 0;
        stop_bit_detected <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= DETECT_START_BIT;
                end
            end
            DETECT_START_BIT: begin
                if (in == 1) begin
                    state <= RECEIVING_DATA;
                    start_bit_detected <= 1;
                    received_data <= 0;
                end
            end
            RECEIVING_DATA: begin
                received_data <= {in, received_data[7:1]};
                if (received_data == 8'b11111110) begin
                    state <= DETECT_STOP_BIT;
                end
            end
            DETECT_STOP_BIT: begin
                if (in == 1) begin
                    stop_bit_detected <= 1;
                    state <= IDLE;
                    done <= 1;
                end else begin
                    state <= RECEIVING_DATA;
                    stop_bit_detected <= 0;
                end
            end
        endcase
    end
end

endmodule
