module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] message;
    reg [1:0] byte_count;

    // State encoding
    localparam IDLE = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case(state)
            IDLE: begin
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end

            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output and state-dependent actions
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
            byte_count <= 0;
            message <= 0;
            out_bytes <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                    done <= 0;
                    byte_count <= 0;
                    if (in[3] == 1)
                        message[23:16] <= in;
                end

                BYTE1: begin
                    message[23:16] <= message[23:16];
                    message[15:8] <= in;
                end

                BYTE2: begin
                    message[15:8] <= message[15:8];
                    message[7:0] <= in;
                end

                BYTE3: begin
                    message[7:0] <= message[7:0];
                    out_bytes <= message;
                    done <= 1;
                end
            endcase
        end
    end

endmodule
