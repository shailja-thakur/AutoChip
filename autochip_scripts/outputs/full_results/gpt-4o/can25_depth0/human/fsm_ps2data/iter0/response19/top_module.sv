module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [7:0] byte1, byte2, byte3;

    // State Transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // FSM Logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
                done = 0;
            end
            BYTE1: begin
                next_state = BYTE2;
                done = 0;
            end
            BYTE2: begin
                next_state = BYTE3;
                done = 0;
            end
            BYTE3: begin
                next_state = IDLE;
                done = 1;
            end
            default: begin
                next_state = IDLE;
                done = 0;
            end
        endcase
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'h000000;
            byte1 <= 8'h00;
            byte2 <= 8'h00;
            byte3 <= 8'h00;
        end else begin
            case (state)
                IDLE: begin
                    if (in[3] == 1) begin
                        byte1 <= in;
                    end
                end
                BYTE1: begin
                    byte2 <= in;
                end
                BYTE2: begin
                    byte3 <= in;
                end
                BYTE3: begin
                    out_bytes <= {byte1, byte2, byte3};
                end
            endcase
        end
    end

endmodule
