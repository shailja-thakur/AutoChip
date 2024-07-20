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
        DONE  = 2'b11
    } state_t;

    // State register
    reg [1:0] current_state, next_state;
    reg [23:0] shift_reg;

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            // Shift input into register
            shift_reg <= {shift_reg[15:0], in};
            
			// Update output based on state transition
            if (current_state == DONE) begin
                out_bytes <= shift_reg;
            end
            
			// Update done signal
            done <= (current_state == DONE);
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            BYTE1: begin
                if (in[2] == 1'b1) begin
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
                if (in[2] == 1'b0) begin
                    next_state = BYTE1;
                end else begin
                    next_state = DONE;
                end
            end
            default: next_state = BYTE1;
        endcase
    end

endmodule
