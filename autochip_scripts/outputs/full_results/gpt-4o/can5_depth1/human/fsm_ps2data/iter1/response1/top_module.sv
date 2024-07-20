module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [7:0] byte1, byte2, byte3;

    // Sequential block for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Sequential block for capturing bytes and asserting `done`
    always @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            done <= 0;
        end else begin
            case (next_state)
                IDLE: begin
                    byte1 <= 8'b0;
                    byte2 <= 8'b0;
                    byte3 <= 8'b0;
                    done <= 0;
                end
                BYTE1: begin
                    byte1 <= in;
                    done <= 0;
                end
                BYTE2: begin
                    byte2 <= in;
                    done <= 0;
                end
                DONE: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1;
                end
            endcase
        end
    end

    // Combinational block for next state logic
    always @(*) begin
        next_state = state;
        
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
