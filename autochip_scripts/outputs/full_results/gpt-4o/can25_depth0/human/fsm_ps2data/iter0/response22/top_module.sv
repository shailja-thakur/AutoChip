module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {IDLE, BYTE_1, BYTE_2, BYTE_3} state_t;
    state_t state, next_state;

    reg [7:0] byte1, byte2, byte3;

    // Combinational state logic
    always @(*) begin
        case (state)
            IDLE: next_state = (in[3]) ? BYTE_1 : IDLE;
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Sequential state logic
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Datapath and output logic
    always @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'd0;
            byte2 <= 8'd0;
            byte3 <= 8'd0;
            out_bytes <= 24'd0;
            done <= 1'b0;
        end
        else begin
            case (next_state)
                BYTE_1: byte1 <= in;
                BYTE_2: byte2 <= in;
                BYTE_3: byte3 <= in;
            endcase

            if (state == BYTE_3) begin
                out_bytes <= {byte1, byte2, byte3};
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

endmodule
