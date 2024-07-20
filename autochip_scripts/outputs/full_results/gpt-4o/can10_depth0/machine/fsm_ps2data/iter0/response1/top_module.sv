module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE = 2'b11
    } state_t;

    reg [1:0] current_state, next_state;
    reg [23:0] temp_register;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            temp_register <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state != DONE) begin
                temp_register <= {temp_register[15:0], in};
            end
        end
    end

    // Next state logic
    always @( * ) begin
        case (current_state)
            BYTE1: begin
                if (in[2] == 1'b1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
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
                if (in[2] == 1'b0)
                    next_state = BYTE1;
                else
                    next_state = DONE;
                done = 1'b1;
            end
            default: begin
                next_state = BYTE1;
                done = 1'b0;
            end
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end else begin
            if (done)
                out_bytes <= temp_register;
        end
    end

endmodule
