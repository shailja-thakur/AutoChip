module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    reg [2:0] state;
    reg start_bit_detected;
    reg stop_bit_detected;
    reg [7:0] received_byte;
    wire [7:0] shifted_byte;

    parameter IDLE = 3'b000;
    parameter START_BIT = 3'b001;
    parameter DATA_BITS = 3'b010;
    parameter STOP_BIT = 3'b011;
    parameter BYTE_DONE = 3'b100;

    // Shift register to delay the received bits by 1 clock cycle
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            received_byte <= 8'b0;
        end else begin
            received_byte <= {received_byte[6:0], in};
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_bit_detected <= 0;
            stop_bit_detected <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START_BIT;
                    end
                end
                START_BIT: begin
                    if (in == 1'b0) begin
                        state <= DATA_BITS;
                        received_byte <= 8'b0;
                        start_bit_detected <= 1;
                    end else begin
                        state <= IDLE;
                    end
                end
                DATA_BITS: begin
                    if (in == 1'b1) begin
                        state <= STOP_BIT;
                    end
                end
                STOP_BIT: begin
                    if (in == 1'b1) begin
                        state <= BYTE_DONE;
                        stop_bit_detected <= 1;
                    end else begin
                        state <= IDLE;
                    end
                end
                BYTE_DONE: begin
                    state <= IDLE;
                    start_bit_detected <= 0;
                    stop_bit_detected <= 0;
                end
            endcase
        end
    end

    // Output the byte only when done is true
    always @(posedge clk) begin
        if (done) begin
            out_byte <= shifted_byte;
        end else begin
            out_byte <= 8'b0;
        end
    end

    // Shift the received byte by 1 clock cycle to match data alignment
    assign shifted_byte = {received_byte[0], received_byte[7:1]};

    // Output done when stop bit is detected
    assign done = (state == BYTE_DONE && stop_bit_detected);

endmodule
