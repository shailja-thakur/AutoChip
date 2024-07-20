module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    reg [1:0] current_state, next_state;
    reg [23:0] msg;

    // State transition
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic and outputs
    always @(*) begin
        // Default values
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                end
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

    // Output datapath
    always @(posedge clk) begin
        if (reset) begin
            msg <= 24'b0;
            out_bytes <= 24'b0;
        end else begin
            case (current_state)
                BYTE_1: msg[23:16] <= in;
                BYTE_2: msg[15:8] <= in;
                BYTE_3: msg[7:0] <= in;
            endcase
            if (done) 
                out_bytes <= msg;
        end
    end

endmodule
