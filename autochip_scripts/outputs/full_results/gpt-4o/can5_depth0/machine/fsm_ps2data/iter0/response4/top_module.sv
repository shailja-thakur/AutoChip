module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State definition
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] shift_reg;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and shift register update
    always @(*) begin
        next_state = state;  // default to current state
        done = 0;  // default to not done
        case (state)
            BYTE1: begin
                if (in[2] == 1) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (!in[2]) begin
                    next_state = BYTE1;
                end
            end
        endcase
    end

    // Output logic and register shifts
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
        end else if (done) begin
            out_bytes <= shift_reg;  // when done, output the shift register
        end else begin
            shift_reg <= {shift_reg[15:0], in};  // shift left by 8 bits and input new value
        end
    end

endmodule
