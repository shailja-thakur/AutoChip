module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State declarations
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] shift_register;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_register <= 24'b0;
        end else begin
            state <= next_state;
            shift_register <= shift_register;
            if (state != DONE) begin
                shift_register <= (shift_register << 8) | in;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            BYTE1: 
                if (in[2] == 1) 
                    next_state = BYTE2;
                else 
                    next_state = BYTE1;
            BYTE2: 
                next_state = BYTE3;
            BYTE3: 
                next_state = DONE;
            DONE: 
                if (in[2] == 0) 
                    next_state = BYTE1;
                else 
                    next_state = DONE;
            default: 
                next_state = BYTE1;
        endcase
    end

    // Output logic 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            if (state == DONE) begin
                out_bytes <= shift_register;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

endmodule
