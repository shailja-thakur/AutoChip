module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// States
localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;
reg [1:0] state, next_state;

// Counters
reg [2:0] bit_count;
reg [3:0] sample_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        sample_count <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;

        case (state)
            IDLE: begin
                // Wait for start bit (0)
                if (in == 0) begin
                    next_state <= START;
                    bit_count <= 0;
                    sample_count <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
            end

            START: begin
                // Sample the start bit
                if (sample_count == 7) begin
                    if (in == 0) begin
                        next_state <= DATA;
                    end
                    else begin
                        next_state <= IDLE;
                    end
                    sample_count <= 0;
                end
                else begin
                    sample_count <= sample_count + 1;
                    next_state <= START;
                end
            end

            DATA: begin
                // Sample the data bits
                if (sample_count == 3) begin
                    out_byte[bit_count] <= in;
                    bit_count <= bit_count + 1;
                    sample_count <= 0;
                    if (bit_count == 7) begin
                        next_state <= STOP;
                    end
                    else begin
                        next_state <= DATA;
                    end
                end
                else begin
                    sample_count <= sample_count + 1;
                    next_state <= DATA;
                end
            end

            STOP: begin
                // Sample the stop bit
                if (sample_count == 7) begin
                    if (in == 1) begin
                        done <= 1;
                        next_state <= IDLE;
                    end
                    else begin
                        next_state <= IDLE;
                    end
                end
                else begin
                    sample_count <= sample_count + 1;
                    next_state <= STOP;
                end
            end
        endcase
    end
end

endmodule
