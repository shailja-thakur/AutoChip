module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    reg [23:0] out_reg; // 24-bit register to store out_bytes
    reg [1:0] state; // 2-bit register to store state
 
    always @(posedge clk) begin
        if (reset) begin
            out_reg <= 24'b0; // Reset out_reg to all zeros
            state <= 2'b00; // Reset state to BYTE1
        end else begin
            // State machine transitions
            case(state)
                2'b00: begin // BYTE1 state
                    if (in[2] == 1'b1) begin // Transition to BYTE2 if third bit of input is 1
                        state <= 2'b01;
                    end else begin // Stay in BYTE1 if third bit of input is 0
                        state <= 2'b00;
                    end
                end
                2'b01: begin // BYTE2 state
                    state <= 2'b10; // Always transition to BYTE3
                end
                2'b10: begin // BYTE3 state
                    state <= 2'b11; // Always transition to DONE
                end
                2'b11: begin // DONE state
                    if (in[2] == 1'b0) begin // Transition to BYTE1 if third bit of input is 0
                        state <= 2'b00;
                    end else begin // Stay in DONE if third bit of input is 1
                        state <= 2'b11;
                    end
                end
            endcase
             
            // Update out_reg on rising edge of clock
            if (state == 2'b11) begin // Only update out_reg when in DONE state
                out_reg <= {out_reg[15:0], in}; // Shift input into out_reg, shifting left by 8 bits
            end
        end
    end
 
    assign out_bytes = out_reg; // Assign out_reg to out_bytes
 
    // Set done signal when in DONE state
    assign done = (state == 2'b11);
endmodule
