module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] buffer;
    reg [1:0] byte_count;

    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t curr_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            curr_state <= IDLE;
            byte_count <= 2'b00;
        end else begin
            curr_state <= next_state;
            if (next_state != IDLE) begin
                byte_count <= byte_count + 1;
            end else begin
                byte_count <= 2'b00;
            end
        end
    end

    // Combinatorial logic for next state logic
    always @(*) begin
        case (curr_state)
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

    // Sequential logic for outputs and buffer
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'h000000;
            buffer <= 24'h000000;
            done <= 1'b0;
        end else begin
            if (curr_state == BYTE3) begin
                out_bytes <= {buffer[15:0], in};
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end

            case (curr_state)
                BYTE1: buffer[23:16] <= in;
                BYTE2: buffer[15:8] <= in;
                BYTE3: buffer[7:0] <= in;
            endcase
        end
    end

endmodule
