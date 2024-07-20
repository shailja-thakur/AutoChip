module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    reg [7:0] data_reg; // Register to store received data bits
    reg [2:0] state; // FSM state register
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0; // Reset state
            data_reg <= 8'b0; // Reset data register
            out_byte <= 8'b0; // Reset output byte
            done <= 0; // Reset done signal
        end else begin
            case (state)
                0: begin // Idle state
                    if (in == 1'b0) begin
                        state <= 1; // Transition to start bit state
                        data_reg <= 8'b0; // Reset data register
                    end else begin
                        state <= 0; // Stay in idle state
                        data_reg <= 8'b0; // Reset data register
                    end
                end
                1: begin // Start bit state
                    if (in == 1'b0) begin
                        state <= 2; // Transition to data bits state
                    end else begin
                        state <= 0; // Go back to idle state
                        data_reg <= 8'b0; // Reset data register
                    end
                end
                2: begin // Data bits state
                    data_reg <= {data_reg[6:0], in}; // Shift input bit to data register
                    
                    if (data_reg == 8'b11111110) begin
                        state <= 3; // Transition to stop bit state
                    end else begin
                        state <= 2; // Stay in data bits state
                    end
                end
                3: begin // Stop bit state
                    if (in == 1'b1) begin
                        out_byte <= data_reg[7:0]; // Set output byte
                        done <= 1; // Assert done signal
                        state <= 0; // Transition to idle state
                    end else begin
                        state <= 3; // Stay in stop bit state
                    end
                end
            endcase
        end
    end
endmodule
