module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Declare the state variables
    reg [1:0] state;
    reg [23:0] out_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Initialize state to BYTE1
            out_reg <= 24'b0; // Initialize register to 0
            done <= 0; // Initialize done signal to 0
        end else begin
            case (state)
                2'b00: begin // BYTE1 state
                    if (in[2]) begin // Transition to BYTE2 if third bit is 1
                        state <= 2'b01;
                    else
                        state <= 2'b00; // Stay in BYTE1 if third bit is 0
                    end
                end
                2'b01: begin // BYTE2 state
                    state <= 2'b10; // Transition to BYTE3
                end
                2'b10: begin // BYTE3 state
                    state <= 2'b11; // Transition to DONE
                end
                2'b11: begin // DONE state
                    if (!in[2]) begin // Transition to BYTE1 if third bit is 0
                        state <= 2'b00;
                    else
                        state <= 2'b11; // Stay in DONE if third bit is 1
                    end
                end
                default: state <= 2'b00; // Default state is BYTE1
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (done) begin
            out_bytes <= out_reg; // Update out_bytes with the contents of the register
        end
        out_reg <= {out_reg[15:0], in}; // Shift the register left by 8 bits and input the new data from in
    end
    
    always @(state) begin
        done <= (state == 2'b11); // Set done signal to 1 when state is DONE
    end

endmodule
