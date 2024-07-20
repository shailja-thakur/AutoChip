module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state;
    reg [3:0] bit_count;
    reg [7:0] buffer;

    // States
    localparam IDLE = 4'd0,
               START = 4'd1,
               DATA = 4'd2,
               STOP = 4'd3,
               DONE = 4'd4;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            buffer <= 0;
            out_byte <= 0;
            done <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (in == 0) // Start bit detected
                        state <= START;
                end

                START: begin
                    if (in == 0) // Confirm start bit stayed 0
                        state <= DATA;
                    else
                        state <= IDLE; // False start bit detection
                end

                DATA: begin
                    buffer[bit_count] <= in;
                    bit_count <= bit_count + 4'd1;
                    if(bit_count == 4'd7) // 8 data bits received
                        state <= STOP;
                end

                STOP: begin
                    if (in == 1) begin // Stop bit must be 1
                        out_byte <= buffer;
                        done <= 1;
                        state <= DONE;
                    end
                    else begin
                        state <= IDLE; // Error: wait for idle and start over
                    end
                end

                DONE: begin
                    done <= 0;
                    bit_count <= 0;
                    buffer <= 0;
                    if (in == 1) // Wait for line to go idle
                        state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
