module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data_byte;
    reg [3:0] bit_count;

    localparam IDLE = 4'd0,
               START = 4'd1,
               RECEIVE = 4'd2,
               STOP = 4'd3,
               DONE = 4'd4,
               FIND_STOP = 4'd5;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: next_state = (in == 0) ? START : IDLE;
            START: next_state = RECEIVE;
            RECEIVE: next_state = (bit_count == 4'd7) ? STOP : RECEIVE;
            STOP: next_state = (in == 1) ? DONE : FIND_STOP;
            DONE: next_state = (in == 1) ? IDLE : FIND_STOP;
            FIND_STOP: next_state = (in == 1) ? IDLE : FIND_STOP;
            default: next_state = IDLE;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output and data byte register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_byte <= 8'd0;
            bit_count <= 4'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    bit_count <= 4'd0;
                    done <= 1'b0;
                end
                START: begin
                    data_byte <= 8'd0;
                    bit_count <= 4'd0;
                end
                RECEIVE: begin
                    data_byte[bit_count] <= in;
                    bit_count <= bit_count + 4'd1;
                end
                STOP: begin
                    if (in == 1) begin
                        out_byte <= data_byte;
                        done <= 1'b1;
                    end else begin
                        done <= 1'b0; // Stop bit not found
                    end
                end
                DONE: begin
                    done <= 1'b0;
                end
                FIND_STOP: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
