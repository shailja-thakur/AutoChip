module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    
    // State declarations
    typedef enum reg [1:0] {
        BYTE1 = 2'd0,
        BYTE2 = 2'd1,
        BYTE3 = 2'd2,
        DONE  = 2'd3
    } state_t;
    
    reg [1:0] current_state, next_state;
    reg [23:0] shift_reg;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            shift_reg <= 24'd0;
            out_bytes <= 24'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE1 || current_state == BYTE2 || current_state == BYTE3) begin
                shift_reg <= {shift_reg[15:0], in};  // Shift in the new byte
            end
            if (current_state == DONE) begin
                out_bytes <= shift_reg;
            end else begin
                out_bytes <= 24'd0;
            end
        end
    end

    // Next state logic and done signal
    always @(*) begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            BYTE1: begin
                if (in[2] == 1'b1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (in[2] == 1'b0)
                    next_state = BYTE1;
            end
        endcase
    end

endmodule
