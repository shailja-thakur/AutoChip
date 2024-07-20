module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // States
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] message;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in[3]) next_state = BYTE_1;
            end
            BYTE_1: begin
                next_state = BYTE_2;
            end
            BYTE_2: begin
                next_state = BYTE_3;
            end
            BYTE_3: begin
                next_state = IDLE;
                done = 1'b1;
            end
        endcase
    end

    // Capture bytes and generate output
    always_ff @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            message <= 24'b0;
        end else begin
            case (state)
                BYTE_1: begin
                    message[23:16] <= in;
                end
                BYTE_2: begin
                    message[15:8] <= in;
                end
                BYTE_3: begin
                    message[7:0] <= in;
                    out_bytes <= {message[23:8], in};
                end
            endcase
        end
    end

endmodule
