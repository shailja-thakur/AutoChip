module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    reg [2:0] state;              // State variable
    reg [23:0] shift_register;    // 24-bit shift register
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;         // Initial state is BYTE1
            shift_register <= 24'b0; // Reset the shift register
            done <= 0;               // Initialize done signal to 0
        end else begin
            case (state)
                3'b000: begin          // BYTE1 state
                    if (in[2] == 1) begin
                        state <= 3'b001; // Transition to BYTE2 if third bit of input is 1
                    else
                        state <= 3'b000; // Transition to BYTE1 if third bit of input is 0
                    end
                    // Shift input into the register
                    shift_register <= {shift_register[15:0], in};
                end
                3'b001: begin          // BYTE2 state
                    state <= 3'b010;     // Transition to BYTE3
                    // Shift input into the register
                    shift_register <= {shift_register[15:0], in};
                end
                3'b010: begin          // BYTE3 state
                    state <= 3'b011;     // Transition to DONE
                    // Shift input into the register
                    shift_register <= {shift_register[15:0], in};
                end
                3'b011: begin          // DONE state
                    if (in[2] == 0)
                        state <= 3'b000; // Transition to BYTE1 if third bit of input is 0
                    else
                        state <= 3'b011; // Stay in DONE state if third bit of input is 1
                    // Shift input into the register
                    shift_register <= {shift_register[15:0], in};
                end
            endcase
        end
    end
    
    // Assign out_bytes and done signals
    assign done = (state == 3'b011);     // done signal is set to 1 in DONE state
    assign out_bytes = (done) ? shift_register : 24'b0;
    
endmodule
