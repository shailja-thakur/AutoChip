module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11} state_t;
    reg [1:0] state, next_state;
    reg [23:0] register;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            register <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state != DONE) begin
                register <= {register[15:0], in};
            end
        end
    end

    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[2] == 1'b1) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
                done = 1'b0;
            end
            BYTE2: begin
                next_state = BYTE3;
                done = 1'b0;
            end
            BYTE3: begin
                next_state = DONE;
                done = 1'b0;
            end
            DONE: begin
                if (in[2] == 1'b0) begin
                    next_state = BYTE1;
                end else begin
                    next_state = DONE;
                end
                done = 1'b1;
            end
            default: begin
                next_state = BYTE1;
                done = 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (state == DONE && done == 1'b1) begin
            out_bytes <= register;
        end else begin
            out_bytes <= 24'b0;
        end
    end

endmodule
