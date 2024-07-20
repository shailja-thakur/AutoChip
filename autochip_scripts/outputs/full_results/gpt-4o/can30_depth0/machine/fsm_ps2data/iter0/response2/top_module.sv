module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] shift_reg;

    // State encoding
    parameter BYTE1 = 2'b00,
              BYTE2 = 2'b01,
              BYTE3 = 2'b10,
              DONE  = 2'b11;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'd0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and output logic
    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            BYTE1: begin
                if (in[2]) // Third bit is 1
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
                next_state = BYTE1;
                done = 1'b1;
            end
        endcase
    end

    // Shift register and out_bytes updating logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'd0;
            out_bytes <= 24'd0;
        end
        else if (state == BYTE1 && in[2] || state == BYTE2 || state == BYTE3) begin
            shift_reg <= {shift_reg[15:0], in}; // Shift in new 8-bit input
        end
        else if (state == DONE) begin
            out_bytes <= shift_reg;
        end
    end
endmodule
