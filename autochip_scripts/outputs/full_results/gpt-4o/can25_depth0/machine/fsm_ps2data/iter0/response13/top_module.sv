module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State Encoding
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] register;

    // State Transition Logic
    always @(*) begin
        case (state)
            BYTE1: next_state = in[2] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // State Flip-Flops with Synchronous Reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Output Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            register <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            if (state == DONE) begin
                done <= 1'b1;
                out_bytes <= register;
            end else begin
                done <= 1'b0;
                register <= {register[15:0], in}; // Shift left by 8 bits and add new input
            end
        end
    end

endmodule
